require "./generate"
include FileUtils

mkdir_p SITE_DIR.to_s

STATIC_FILES = %w[site.css site.js favicon.ico 404.html play.png clipboard.png]

cp srcs: STATIC_FILES.map { |path| (TEMPLATE_DIR / path).to_s },
  dest: SITE_DIR.to_s

parse_examples.write
