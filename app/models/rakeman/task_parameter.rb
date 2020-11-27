# frozen_string_literal: true

module Rakeman
  class TaskParameter < ApplicationRecord
    validates :name, presence: true

    belongs_to :task, class_name: 'Rakeman::RakeTask', foreign_key: :rakeman_rake_task_id
  end
end
