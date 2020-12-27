# frozen_string_literal: true

module Rakeman
  module Web
    module Tasks
      class Run < ApplicationService
        def initialize(params)
          @task = Rakeman::RakeTask.find_by(id: params[:id])
          @params = params.fetch(:task_parameters) { {} }.permit!.to_h
          @manager = Rakeman::Manager.new
        end

        def call
          return validation_failure unless @task && needed_task_params?

          passed_params = task_parameters.map { |param| @params[param.id.to_s] }
          @manager.execute(@task, passed_params)
          success!
        rescue RuntimeError => e
          failure!(message: e.message)
        end

        private

        def task_parameters
          @task_parameters ||= @task.params.find(@params.keys).sort_by(&:parameter_position)
        rescue ActiveRecord::RecordNotFound
          @task_parameters ||= []
        end

        def needed_task_params?
          !@task.params.exists? || task_parameters.any?
        end

        def validation_failure
          failure!(message: I18n.t('rakeman.task_parameters.not_found'))
        end
      end
    end
  end
end
