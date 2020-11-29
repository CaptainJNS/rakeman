# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rakeman::TaskParameter, type: :model do
  describe 'Columns' do
    it { is_expected.to have_db_column(:name) }
    it { is_expected.to have_db_column(:rakeman_rake_task_id) }
    it { is_expected.to have_db_column(:parameter_position) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:task) }
  end
end
