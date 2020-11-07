# frozen_string_literal: true

module Rakeman::TaskCreator
  RAKE_REGEX = /rake ([\w\[\],:]+) #/.freeze
  DESC_REGEX = /# ([\w\W]+)/.freeze
  MATCH_INDEX = 1

  def create_tasks(tasks_list: nil, destroy_old_tasks: true)
    Rakeman::RakeTask.destroy_all if destroy_old_tasks

    tasks_list ||= tasks

    tasks_list.each do |task|
      Rakeman::RakeTask.create(name: task[:name], description: task[:description])
    end
  end

  def tasks
    tasks = `rake -T`.split("\n").map { |task| task.squeeze(' ') }

    parse_to_hash(tasks)
  end

  private

  def parse_to_hash(tasks)
    tasks.map do |task|
      { name: RAKE_REGEX.match(task)[MATCH_INDEX], description: DESC_REGEX.match(task)[MATCH_INDEX] }
    end
  end
end
