# frozen_string_literal: true

RSpec.describe Rakeman::Manager do
  let(:manager) { described_class.new }

  let(:task1) { instance_double('task', name: 'task1', full_comment: 'Task 1 Description', arg_names: []) }
  let(:task2) { instance_double('task', name: 'task2', full_comment: 'Task 2 Description', arg_names: []) }
  let(:task3) do
    instance_double('task', name: 'task3', full_comment: 'Task 3 Description', arg_names: %w[arg1 arg2])
  end
  let(:unparsed_list) { [task1, task2, task3] }

  before do
    allow(Rake::Task).to receive(:tasks).and_return(unparsed_list)
  end

  describe '#all_tasks_list' do
    let(:expected_list) do
      [
        {
          name: 'task1',
          description: 'Task 1 Description',
          args: []
        },
        {
          name: 'task2',
          description: 'Task 2 Description',
          args: []
        },
        {
          name: 'task3',
          description: 'Task 3 Description',
          args: %w[arg1 arg2]
        }
      ]
    end

    it 'gets list of all rake tasks' do
      manager.all_tasks_list
      expect(Rake::Task).to have_received(:tasks)
    end

    it 'parses task list to array of hashes' do
      expect(manager.all_tasks_list)
        .to match_array(expected_list)
    end
  end

  describe '#persist_tasks' do
    context 'when no tasks exist yet' do
      it 'creates rake_tasks and task_parameters' do
        expect { manager.persist_tasks }
          .to change(Rakeman::RakeTask, :count)
          .from(0).to(3)
          .and change(Rakeman::TaskParameter, :count)
          .from(0).to(2)
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
            name: task_name,
            args: []
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
