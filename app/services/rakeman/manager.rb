# frozen_string_literal: true

module Rakeman
  class Manager
    include TaskCreator
    include TaskUpdater
    include TaskRunner

    def execute(task)
      run(task.name)
      mark_as_done(task)
    end

    def update_tasks_list
      tasks_to_create = update_tasks(tasks)
      persist_tasks(tasks_list: tasks_to_create, destroy_old_tasks: false)
    end
  end
end
