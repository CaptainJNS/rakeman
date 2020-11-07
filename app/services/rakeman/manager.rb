# frozen_string_literal: true

# require 'rakeman/version'
# require_relative 'rakeman/task_creator'
# require_relative 'rakeman/task_updater'
# require_relative 'rakeman/task_runner'

module Rakeman
  class Manager
    include TaskCreator
    include TaskUpdater
    include TaskRunner

    def execute(task)
      run(task.name)
      mark_as_done(task)
    end
  end
end
