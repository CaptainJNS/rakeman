# frozen_string_literal: true

RSpec.describe Rakeman::RakeTask, type: :model do
  describe 'Columns' do
    it { is_expected.to have_db_column(:name) }
    it { is_expected.to have_db_column(:done) }
    it { is_expected.to have_db_column(:description) }
  end

  describe 'Validations' do
    it { is_expected.to allow_value('namespace1:namespace2:task_name[param1,param2]').for(:name) }
    it { is_expected.not_to allow_value('&& rm -rf *').for(:name).with_message('Wrong name format!') }
  end
end
