require 'split-app'

module SplitApp
  if defined? Rails::Railtie
    require 'rails'
    class Railtie < Rails::Railtie
      rake_tasks do
        load "tasks/split-app.rake"
      end
    end
  end
end