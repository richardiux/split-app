def obtain_engine_name
  @engine_name = ENV['ENGINE'] || ENV['engine']
  raise "Must specify engine" unless @engine_name
end

def app_gems
  @app_gems ||= File.read('.appgems').collect{ |x| x.strip }
end

def engines_to_process
  @engine_name ? @engine_name : app_gems.each
end

namespace :app do
  obtain_engine_name

  desc "Prepares an engine to be worked in."
  task :prepare => ["app:clean_symlinks", "app:core_symlink"]
  
  task :clean_symlinks do
    engines_to_process.each do |framework|
      symlinks = Dir["engines/#{framework}/**/*"].select{ |file_name| File.symlink?(file_name) }
      symlinks.each do |file_name|
        File.delete(file_name)
      end
    end
  end
  
  task :core_symlink do
    engines_to_process.each do |framework|
      app_shared = File.read('.appshared').collect{ |x| x.strip }
      app_shared.each do |shared_file|
        subdirectories = shared_file.split('/').count + 1
        base_path = subdirectories.times.collect{'..'}.join('/')
        `ln -sf #{base_path}/#{shared_file} engines/#{framework}/#{shared_file}`
      end
      Dir['../config/*'].collect{|f| f.gsub(/\.\.\//, '')}.each do |file|
        `ln -sf ../../../#{file} engines/#{framework}/#{file}`
      end
    end
  end
  
  desc "Build all app gems"
  task :build do
    engines_to_process.each do |gem_name|
      gem_path = "engines/#{gem_name}"
      `cd #{gem_path}; gem build #{gem_name}.gemspec`
      Dir["#{gem_path}/*.gem"].each do |new_gem|
        puts "Installing gem #{gem_name}"
        # `gem uninstall #{gem_name} -a`
        `gem install #{new_gem} --no-ri --no-rdoc --force`
        `rm #{new_gem}`
        `rm -f ../vendor/cache/#{gem_name}*`
      end
      # `cd ..; bundle install`
    end
  end
end