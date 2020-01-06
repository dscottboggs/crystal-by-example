require "uri"
require "digest/md5"
require "http"
require "./run_request"

class FailedPlaygroundRequest < Exception
  property example : String
  property response : HTTP::Client::Response

  def initialize(@example, @response)
    super "failed to run #{example} in the playground:\n#{pp response}"
  end
end

module GenerateHashFile
  extend self
  BUFFER_SIZE            = 0x1000
  EXAMPLE_DIR            = Path[__DIR__, "examples"]
  PLAYGROUND_BASE_URL    = URI.parse ENV.fetch "PLAYGROUND_URL", default: "https://carc.in"
  CRYSTAL_VERSION        = `crystal --version | head -n1 | cut -d' ' -f2`.strip
  JSON_TRANSPORT_HEADERS = begin
    headers = HTTP::Headers.new
    headers["Content-Type"] = "application/json"
    headers["Accept"] = "application/json"
    headers
  end

  def base64_md5sum(file path : Path) : String
    buffer = uninitialized UInt8[BUFFER_SIZE]
    buffer_ptr = Slice.new pointer: buffer.to_unsafe, size: BUFFER_SIZE

    File.open path do |file|
      sum = Digest::MD5.digest do |hasher|
        until (bytes_read = file.read buffer_ptr) == 0
          hasher.update inBuf: buffer_ptr.to_unsafe, inLen: bytes_read
        end
      end
      return Base64.urlsafe_encode sum.to_slice, padding: false
    end
  end

  def get_playground_id(for example : String)
    code_path = EXAMPLE_DIR / example / (example + ".cr")
    request_data = RunRequest.new language: "crystal", code: File.read code_path
    puts request_data.to_pretty_json
    # version: CRYSTAL_VERSION, code: File.read code_path
    response = HTTP::Client.post "#{PLAYGROUND_BASE_URL}/run_requests",
      body: request_data.to_json, headers: JSON_TRANSPORT_HEADERS
    raise FailedPlaygroundRequest.new example, response unless response.success?
    RunResponse.from_json(response.body_io? || response.body).run_request.id
  end

  def gen_hash_file(for example : String) : Nil
    File.open EXAMPLE_DIR / example / (example + ".hash"), mode: "w" do |file|
      file.puts base64_md5sum EXAMPLE_DIR / example / (example + ".cr")
      file.puts get_playground_id for: example
    end
  end
end

ARGV.each do |example|
  GenerateHashFile.gen_hash_file for: example
end
