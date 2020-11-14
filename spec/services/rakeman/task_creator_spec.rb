# frozen_string_literal: true

RSpec.describe Rakeman::Manager do
  let(:manager) { described_class.new }

  let(:unparsed_list) do
    "rake task1            # Task 1 Description
      rake task2            # Task 2 Description
      rake task3          # Task 3 Description"
  end

  before do
    allow(manager).to receive(:`).with('rake -T').and_return(unparsed_list)
  end

  describe '#all_tasks_list' do
    let(:expected_list) do
      [
        {
          name: 'task1',
          description: 'Task 1 Description'
        },
        {
          name: 'task2',
          description: 'Task 2 Description'
        },
        {
          name: 'task3',
          description: 'Task 3 Description'
        }
      ]
    end

    it 'gets list of all rake tasks' do
      manager.all_tasks_list
      expect(manager).to have_received(:`).with('rake -T')
    end

    it 'parses task list to array of hashes' do
      expect(manager.all_tasks_list)
        .to match_array(expected_list)
    end
  end

  describe '#persist_tasks' do
    context 'when no tasks exist yet' do
      it 'creates rake_tasks' do
        expect { manager.persist_tasks }.to change(Rakeman::RakeTask, :count).from(0).to(3)
      end
    end

    context 'when 1 tasks exist and destroy_old_tasks: true (by default)' do
      let!(:task) { create(:rake_task) }

      it 'creates rake_tasks' do
        expect { manager.persist_tasks }.to change(Rakeman::RakeTask, :count).from(1).to(3)
      end

      it 'deletes old tasks' do
        manager.persist_tasks
        expect(Rakeman::RakeTask.find_by(id: task.id)).not_to be_present
      end
    end

    context 'when 1 tasks exist and destroy_old_tasks: false' do
      let!(:task) { create(:rake_task) }

      it 'creates rake_tasks' do
        expect { manager.persist_tasks(destroy_old_tasks: false) }.to change(Rakeman::RakeTask, :count).from(1).to(4)
      end

      it 'does not deletes old tasks' do
        manager.persist_tasks(destroy_old_tasks: false)
        expect(Rakeman::RakeTask.find_by(id: task.id)).to be_present
      end
    end

    context 'when custom collection passed' do
      let(:task_name) { Faker::Lorem.word }
      let(:tasks_list) do
        [
          {
            name: task_name
          }
        ]
      end

      it 'creates rake_tasks' do
        expect { manager.persist_tasks(tasks_list: tasks_list) }.to change(Rakeman::RakeTask, :count).from(0).to(1)
      end

      it 'creates task from collection' do
        manager.persist_tasks(tasks_list: tasks_list)
        expect(Rakeman::RakeTask.find_by(name: task_name)).to be_present
      end
    end
  end
end
