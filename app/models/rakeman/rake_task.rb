# frozen_string_literal: true

module Rakeman
  class RakeTask < ApplicationRecord
    TASK_NAME_REGEX = /\A[\w\[\],:]+\Z/.freeze

    validates :name,
              format: { with: TASK_NAME_REGEX, on: %i[create update], message: I18n.t('errors.validation.name_format') }
  end
end
