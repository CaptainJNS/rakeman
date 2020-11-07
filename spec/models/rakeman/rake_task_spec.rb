# frozen_string_literal: true

describe Rakeman::RakeTask, type: :model do
  # subject(:task) { create(:rakeman_rake_task) }

  describe 'Columns' do
    it { is_expected.to have_db_column(:name).with_options(null: false) }
    it { is_expected.to have_db_column(:done).with_options(default: false) }
    it { is_expected.to have_db_column(:description).with_options(null: true) }
  end
end
