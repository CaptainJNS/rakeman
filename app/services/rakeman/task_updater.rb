# frozen_string_literal: true

module Rakeman::TaskUpdater
  def mark_as_done(task)
    task.update(done: true)
  end

  def mark_as_undone(task)
    task.update(done: false)
  end

  private

  def update_tasks(new_tasks)
    @new_tasks = new_tasks

    destroy_old_tasks
    update_description
    generate_new_tasks_hash
  end

  def destroy_old_tasks
    new_task_names = @new_tasks.pluck(:name)
    Rakeman::RakeTask.where.not(name: new_task_names).destroy_all
  end

  def update_description
    Rakeman::RakeTask.all.each do |old_task|
      description = @new_tasks.detect { |new_task| new_task[:name] == old_task[:name] }[:description]
      old_task.update(description: description) if old_task.description != description
    end
  end

  def generate_new_tasks_hash
    old_task_names = Rakeman::RakeTask.pluck(:name)
    @new_tasks.reject { |task| old_task_names.include?(task[:name]) }
  end
end
