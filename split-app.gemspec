require File.expand_path("../lib/split-app/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "split-app"
  s.version     = SplitApp::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Richard Millan"]
  s.email       = ["richardiux@gmail.com"]
  s.homepage    = "http://github.com/richardiux/split-app"
  s.summary     = "Split a large app into interconnected engines"
  s.description = "Simplify development by splitting a large app into smaller maintainable engines"

  s.required_rubygems_version = ">= 1.3.6"

  # lol - required for validation
  s.rubyforge_project         = "split-app"

  # If you have other dependencies, add them here
  # s.add_dependency "another", "~> 1.2"

  # If you need to check in files that aren't .rb files, add them here
  s.files        = Dir["{lib}/**/*.rb", "{lib}/**/*.rake", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'

end
