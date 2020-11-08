# frozen_string_literal: true

require 'rails/generators'

module Rakeman
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    def copy_engine_config
      copy_file 'initializer.rb', 'config/initializers/rakeman.rb'
    end

    def setup_routes
      route <<-ROUTE
        mount Rakeman::Engine => '/rakeman'
      ROUTE
    end
  end
end
