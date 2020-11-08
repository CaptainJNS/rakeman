# frozen_string_literal: true

RSpec.describe Rakeman::Manager do
  let(:manager) { described_class.new }

  describe '#mark_as_done' do
    let(:task) { create(:rake_task) }

    it 'updates rake task' do
      expect { manager.mark_as_done(task) }.to change { task.reload.done }.from(false).to(true)
    end
  end

  describe '#mark_as_undone' do
    let(:task) { create(:rake_task, done: true) }

    it 'updates rake task' do
      expect { manager.mark_as_undone(task) }.to change { task.reload.done }.from(true).to(false)
    end
  end

  describe '#update_list' do
    let(:new_description1) { Faker::Lorem.sentence }
    let(:new_description2) { Faker::Lorem.sentence }
    let(:new_task_name) { Faker::Lorem.word }

    let!(:task1) { create(:rake_task, done: true) }
    let!(:task2) { create(:rake_task) }
    let!(:task3) { create(:rake_task) }

    let(:unparsed_list) do
      "rake #{task1.name}            # #{new_description1}
        rake #{task2.name}            # #{new_description2}
        rake #{Faker::Lorem.word}          # #{Faker::Lorem.sentence}"
    end

    before do
      allow(manager).to receive(:`).with('rake -T').and_return(unparsed_list)
    end

    it 'updates tasks description and saves tasks state' do
      expect { manager.update_tasks_list }
        .to change { task1.reload.description }
        .from(task1.description).to(new_description1)
        .and change { task2.reload.description }
        .from(task2.description).to(new_description2)
        .and avoid_changing(task1.reload, :done)
        .and avoid_changing(task2.reload, :done)
    end

    it 'removes old tasks' do
      manager.update_tasks_list
      expect(Rakeman::RakeTask.find_by(id: task3.id)).not_to be_present
    end
  end
end
