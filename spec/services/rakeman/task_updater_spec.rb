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
    let(:new_task_name) { Faker::Lorem.unique.word }

    let!(:task1) { create(:rake_task, done: true) }
    let!(:task2) { create(:rake_task) }
    let!(:task3) { create(:rake_task) }

    let(:task_double1) do
      instance_double('task', name: task1.name, full_comment: new_description1, arg_names: [])
    end
    let(:task_double2) do
      instance_double('task', name: task2.name, full_comment: new_description2, arg_names: [])
    end
    let(:task_double3) do
      instance_double(
        'task',
        name: Faker::Lorem.unique.word,
        full_comment: Faker::Lorem.sentence,
        arg_names: []
      )
    end
    let(:unparsed_list) { [task_double1, task_double2, task_double3] }

    before do
      allow(Rake::Task).to receive(:tasks).and_return(unparsed_list)
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
