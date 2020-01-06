require "uri"
require "json"

class URI
  def self.new(pull parser : JSON::PullParser)
    parse raw_url: parser.read_string
  end

  def to_json(builder : JSON::Builder) : Nil
    builder.scalar to_s
  end
end

struct RunRequest
  include JSON::Serializable
  property run_request : Run

  def initialize(language, code, version = nil)
    @run_request = Run.new language, code, version
  end

  struct Run
    include JSON::Serializable

    def initialize(@language, @code, @version = nil); end

    property language : String
    property code : String
    property version : String?
  end
end

struct RunResponse
  include JSON::Serializable

  @[JSON::Field(root: "run")]
  property run_request : Run

  struct Run
    include JSON::Serializable
    property id : String
    property version : String
    property stdout : String
    property stderr : String
    property exit_code : UInt8
    @[JSON::Field(converter: Time::Format.new("%FT%TZ"))]
    property created_at : Time
    property url : URI
    property html_url : URI
    property download_url : URI
  end
end
