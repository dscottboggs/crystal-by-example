require "digest/md5"

module GenerateHashFile
  extend self
  BUFFER_SIZE = 0x1000
  EXAMPLE_DIR = Path[__DIR__, "examples"]

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

  def gen_hash_file(for example : String) : Nil
    File.open EXAMPLE_DIR / example / (example + ".hash"), mode: "w" do |file|
      file.puts base64_md5sum EXAMPLE_DIR / example / (example + ".cr")
    end
  end
end

ARGV.each do |example|
  GenerateHashFile.gen_hash_file for: example
end
