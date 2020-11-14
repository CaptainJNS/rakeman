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

    def execute(task, params = nil)
      run(task.name, params)
      mark_as_done(task)
    end

    def update_tasks_list
      tasks_to_create = update_tasks(all_tasks_list)
      persist_tasks(tasks_list: tasks_to_create, destroy_old_tasks: false)
    end
  end
end
