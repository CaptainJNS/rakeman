# frozen_string_literal: true

module Rakeman
  module WEB
    module Tasks
      class Run
        extend Rakeman::Lib::Callable

        def initialize(task, params, manager)
          @task = task
          @params = params[:task_parameters].permit!.to_h
          @manager = manager
        end

        def call
          return unless params_valid?

          passed_params = @task_parameters.sort(&:parameter_position).map do |param|
            @params[param.id.to_s]
          end

          @manager.execute(@task, passed_params)
        end

        private

        def params_valid?
          task_parameter_ids = @params.keys
          @task_parameters = @task.params.where(id: task_parameter_ids)

          @task_parameters.size == task_parameter_ids.size
        end
      end
    end
  end
end
