# frozen_string_literal: true

Rakeman::Engine.routes.draw do
  root 'rake_tasks#index', as: 'index'

  get 'rake_tasks/mark_as_done/:id', to: 'rake_tasks#mark_as_done', as: 'mark_as_done'
  get 'rake_tasks/mark_as_undone/:id', to: 'rake_tasks#mark_as_undone', as: 'mark_as_undone'
  post 'rake_tasks/execute/:id', to: 'rake_tasks#execute', as: 'execute_task'
  get 'rake_tasks/update_list', to: 'rake_tasks#update_tasks_list', as: 'update_tasks_list'
end
