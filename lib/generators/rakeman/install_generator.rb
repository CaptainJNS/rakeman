# frozen_string_literal: true

require 'rails/generators'

module Rakeman
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    def copy_engine_config
      copy_file 'initializer.rb', 'config/initializers/rakeman.rb'
    end

    def copy_sitemap_config
      copy_file 'rakeman.rb', 'config/rakeman.rb'
    end

    def setup_routes
      route <<-ROUTE
        mount Rakeman::Engine => '/'
      ROUTE
    end
  end
end
