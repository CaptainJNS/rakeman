# frozen_string_literal: true

require 'rake'

module Rakeman
  class Engine < ::Rails::Engine

    isolate_namespace Rakeman

    config.autoload_paths += [Rakeman::Engine.root.join('config', 'initializers')]
    config.i18n.load_path += Dir['config/locales/rakeman/**/*.yml']

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.assets false
      g.helper false
    end

    initializer :rakeman do |app|
      ActiveSupport::Notifications.subscribe('active_admin.application.before_load') do
        Dir[app.root.join('app', 'models', '**', '*.rb')].each { |file| require_dependency(file) }
      end
    end

    config.before_initialize do
      ActiveSupport.on_load :action_controller do
        ::ActionController::Base.helper Rakeman::Engine.helpers
      end
    end

    Rake::TaskManager.record_task_metadata = true
  end
end
