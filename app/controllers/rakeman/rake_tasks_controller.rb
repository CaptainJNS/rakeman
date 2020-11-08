# frozen_string_literal: true

class Rakeman::RakeTasksController < ApplicationController
  delegate :update_tasks_list, to: :manager

  def index
    manager.persist_tasks unless Rakeman::RakeTask.any?

    @tasks = Rakeman::RakeTask.order(:name)
  end

  def mark_as_done
    manager.mark_as_done(task)

    redirect I18n.t('actions.tasks.marked_as_done')
  end

  def mark_as_undone
    manager.mark_as_undone(task)

    redirect I18n.t('actions.tasks.marked_as_undone')
  end

  def execute
    manager.execute(task)

    redirect I18n.t('actions.tasks.executed')
  end

  def update_tasks_list
    manager.update_tasks_list

    redirect I18n.t('actions.tasks.list_updated')
  end

  private

  def manager
    @manager ||= Rakeman::Manager.new
  end

  def task
    @task ||= Rakeman::RakeTask.find_by(id: params[:id])
  end

  def redirect(message)
    redirect_to index_path, notice: message
  end
end
