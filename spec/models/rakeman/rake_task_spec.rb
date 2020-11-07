# frozen_string_literal: true

RSpec.describe Rakeman::RakeTask, type: :model do
  # subject(:task) { create(:rake_task) }

  describe 'Columns' do
    it { is_expected.to have_db_column(:name) }
    it { is_expected.to have_db_column(:done) }
    it { is_expected.to have_db_column(:description) }
  end
end
