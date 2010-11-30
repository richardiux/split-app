require "bundler"
Bundler.setup

# require "rspec/core/rake_task"
# Rspec::Core::RakeTask.new(:spec)

gemspec = eval(File.read("split-app.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["split-app.gemspec"] do
  system "gem build split-app.gemspec"
  system "gem install split-app-#{SplitApp::VERSION}.gem"
end
