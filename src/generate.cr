require "markd"
require "file_utils"
require "digest/sha1"
require "ecr"

SITE_DIR            = Path[Dir.current, "public"]
CACHE_DIR           = Path[Dir.tempdir, "crystal-by-example.cache"]
TEMPLATE_DIR        = Path[Dir.current, "templates"]
EXAMPLE_DIR         = Path[__DIR__, "examples"]
DOCS_PATTERN        = /^\s*#\s/
DASH_PATTERN        = /\-+/
PYTHON_PATH         = "/usr/lib/python3.8/site-packages"
PLAYGROUND_BASE_URL = ENV.fetch "PLAYGROUND_URL", default: "https://carc.in"
include FileUtils

def verbose?
  !ENV["VERBOSE"]?.nil?
end

def debug?
  !ENV["DEBUG"]?.nil?
end

def debug(msg)
  puts msg if debug?
end

def install_pygmentize_if_not_found
  if `which pygmentize`.includes? "not found"
    Process.run "python3 -m pip install --user --upgrade pygments", shell: true
  end
end

MAX_CHUNK = 0x1000

def cached_pygmentize(lex : LexerType, src : String) : String
  if src.empty?
    puts "empty source for #{lex} file"
    return ""
  end
  mkdir_p CACHE_DIR.to_s
  arg = ["-l", lex.to_s.downcase, "-f", "html"]
  cache_path = CACHE_DIR / ("pygmentize-" + arg.join('-') + '-' + Base64.urlsafe_encode(Digest::SHA1.digest(src)))
  return File.read cache_path if File.exists? cache_path
  install_pygmentize_if_not_found
  rendered = `echo '#{src}' | pygmentize -l #{lex.to_s.downcase} -f html`
  File.write cache_path, rendered
  rendered
end

enum LexerType
  Crystal
  Shell

  def self.which?(path : String) : self
    case path
    when .ends_with? ".cr" then Crystal
    when .ends_with? ".sh" then Shell
    else                        raise "no lexer for #{path}"
    end
  end
end

class Segment
  property docs : String,
    code : String,
    code_leading : Bool = true,
    code_run : Bool = false # TODO -- original was checked by presence of "package main"
  # This ^^ may need a custom-implemented fork of carc.in with a specific set of
  # statically-linkable files, since by default carc.in files are removed after a while

  property docs_rendered : String { @docs.empty? ? "" : Markd.to_html @docs }
  property code_rendered : String { raise "bug" }
  property code_for_js : String { @code.strip('\n') + '\n' }

  def initialize(@docs, @code)
  end
end

module Renderable
  # ECR.def_to_s is expanded at compile-time so this MUST be a macro
  macro template(file, filetype = "html")
    ECR.def_to_s "#{__DIR__}/templates/{{file.id}}.{{filetype.id}}.ecr"
  end
end

class Example
  property id : String,
    name : String,
    crystal_code : String,
    crystal_code_hash : String,
    segments : Array(Array(Segment)) = [] of Array(Segment)
  property! previous_example : Example, next_example : Example
  property playground_id : String

  include Renderable
  template "example"

  # ECR.def_to_s "#{__DIR__}/templates/example.html.ecr"

  def initialize(@name)
    @id = @name
      .downcase
      .gsub({" ": '-', "/": '-', "'": ""})
      .gsub DASH_PATTERN, '-'
    @crystal_code = File.read EXAMPLE_DIR / id / (id + ".cr")
    @crystal_code_hash = ""
    @crystal_code_hash, @playground_id = File.open(EXAMPLE_DIR / id / (id + ".hash")) do |file|
      {(file.gets || raise "empty hash file"),
       (file.gets || raise "no playground link ID found in hash file")}
    end
    raise "empty/invalid data in hash file" if @crystal_code_hash.empty?
    Dir.each_child (EXAMPLE_DIR / id).to_s do |file|
      unless file.ends_with?(".hash") || File.directory? file
        source_segments, contents = parse_and_render_segs source_path: (EXAMPLE_DIR / id / file).to_s
        crystal_code = contents unless contents.empty?
        segments << source_segments
      end
    end
  end
end

struct Examples
  property examples : Array(Example)

  def initialize(@examples); end

  def to_s(io : IO) : Nil
    ECR.embed "#{__DIR__}/templates/index.html.ecr", "io"
  end

  def write
    puts "rendering index" if verbose?
    File.open SITE_DIR / "index.html", mode: "w" do |file|
      to_s io: file
    end
    puts "rendering examples" if verbose?
    examples.each do |example|
      File.open SITE_DIR / example.id, mode: "w" do |file|
        example.to_s file
      end
    end
  end
end

def parse_segs(source_path : String) : {Array(Segment), String}
  segments = [] of Segment
  last_seen = :none
  file_content = ""
  File.read_lines(source_path).each do |line|
    next last_seen = "" if line.empty?
    file_content += line
    match_docs = DOCS_PATTERN =~ line
    match_code = !match_docs
    new_docs = (last_seen == "") || segments.empty? || ((last_seen != "docs") && segments[-1].docs != "")
    new_code = (last_seen == "") || segments.empty? || ((last_seen != "code") && segments[-1].code != "")
    debug "NEWSEG" if new_docs || new_code
    if match_docs
      trimmed = line.gsub DOCS_PATTERN, ""
      if new_docs
        segments << Segment.new docs: trimmed, code: ""
      else
        segments[-1].docs = segments[-1].docs + '\n' + trimmed
      end
      debug "DOCS: " + line
      last_seen = "docs"
    elsif match_code
      if new_code
        segments << Segment.new docs: "", code: line
      else
        segments[-1].code = segments[-1].code + '\n' + line
      end
      last_seen = "code"
    end
  end
  segments.last.code_leading = false
  {segments, file_content}
end

def parse_and_render_segs(source_path : String) : {Array(Segment), String}
  segments, content = parse_segs source_path
  lexer = LexerType.which? source_path
  segments.each do |segment|
    segment.code_rendered = cached_pygmentize lexer, segment.code
  end
  content = "" unless lexer.crystal?
  {segments, content}
end

def parse_examples
  example_names = File.read_lines("examples.txt").reject { |line| line.empty? || line =~ /^\s*$/ }
  examples = [] of Example
  pp! example_names
  example_names.each_with_index do |example_name, index|
    puts "processing #{example_name} [#{index + 1}/#{example_names.size}]" if verbose?
    # example = Example.new name: example_name
    # new_code_hash = Digest::SHA1.digest example.crystal_code
    # if example.crystal_code_hash != new_code_hash
    #   example.url_hash = reset_url_hash_file new_code_hash, example.crystal_code, "examples/" + example.id + '/' + example.id + ".hash"
    # end
    example = Example.new name: example_name
    unless examples.empty?
      examples[-1].next_example = example
      example.previous_example = examples[-1]
    end
    examples << example
  end
  Examples.new examples
end
