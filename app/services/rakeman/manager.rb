# frozen_string_literal: true

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
