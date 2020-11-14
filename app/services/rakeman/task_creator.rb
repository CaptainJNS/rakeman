# frozen_string_literal: true

module Rakeman::TaskCreator
  def persist_tasks(tasks_list: nil, destroy_old_tasks: true)
    Rakeman::RakeTask.destroy_all if destroy_old_tasks

    tasks_list ||= all_tasks_list

    create_from_list(tasks_list)
  end

  def all_tasks_list
    Rails.application.load_tasks

    parse_to_hash(Rake::Task.tasks)
  end

  private

  def parse_to_hash(tasks)
    tasks.map do |task|
      { name: task.name, description: task.full_comment, args: task.arg_names }
    end
  end

  def create_from_list(tasks_list)
    tasks_list.each do |task_hash|
      task = Rakeman::RakeTask.create(name: task_hash[:name], description: task_hash[:description])
      task_hash[:args].each do |arg_name|
        Rakeman::TaskParameter.create(name: arg_name, task: task)
      end
    end
  end
end
