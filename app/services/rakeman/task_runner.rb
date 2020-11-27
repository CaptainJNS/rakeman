# frozen_string_literal: true

module Rakeman::TaskRunner
  private

  def run(task_name, params)
    return Rake.application.invoke_task("#{task_name}[#{params.join(',')}]") if params

    Rake.application.invoke_task(task_name)
  end
end
