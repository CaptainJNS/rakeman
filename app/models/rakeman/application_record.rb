# frozen_string_literal: true

module Rakeman
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
