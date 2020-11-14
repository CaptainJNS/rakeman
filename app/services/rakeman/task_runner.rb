# frozen_string_literal: true

module Rakeman::TaskRunner
  private

  def run(task_name)
    `rake #{task_name}`
  end
end
