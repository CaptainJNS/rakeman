# frozen_string_literal: true

module Rakeman
  class RakeTask < ApplicationRecord
    TASK_NAME_REGEX = /\A[\w\[\],:]+\Z/.freeze

    validates :name,
              format: {
                with: TASK_NAME_REGEX,
                message: I18n.t('rakeman.errors.validation.name_format')
              }

    has_many :params, foreign_key: :rakeman_rake_task_id, class_name: 'Rakeman::TaskParameter', dependent: :destroy
  end
end
