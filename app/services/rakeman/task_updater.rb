# frozen_string_literal: true

module Rakeman::TaskUpdater
  def update_tasks_list(new_tasks)
    destroy_old_tasks(new_tasks)
    update_description(new_tasks)
    persist_new_tasks(new_tasks)
  end

  def mark_as_done(task)
    task.update(done: true)
  end

  def mark_as_undone(task)
    task.update(done: false)
  end

  private

  def destroy_old_tasks(new_tasks)
    new_task_names = new_tasks.pluck(:name)
    Rakeman::RakeTask.where.not(name: new_task_names).destroy_all
  end

  def update_description(new_tasks)
    Rakeman::RakeTask.all.each do |old_task|
      description = new_tasks.detect { |new_task| new_task[:name] == old_task[:name] }[:description]
      rake_task.update(description: description) if rake_task.description != description
    end
  end

  def persist_new_tasks(new_tasks)
    old_task_names = Rakeman::RakeTask.pluck(:name)
    tasks_to_create = new_tasks.reject { |task| old_task_names.include?(task[:name]) }

    create_tasks(tasks_list: tasks_to_create, destroy_old_tasks: false)
  end
end
