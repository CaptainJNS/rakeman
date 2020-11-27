# frozen_string_literal: true

RSpec.describe Rakeman::Manager do
  let(:manager) { described_class.new }

  let(:task) { create(:rake_task) }
  let(:application_spy) { instance_double('application') }

  describe '#execute' do
    before do
      allow(Rake).to receive(:application).and_return(application_spy)
      allow(application_spy).to receive(:invoke_task).and_return(true)
    end

    context 'with params' do
      let(:params) { %w[arg1 arg2] }

      it 'executes rake task' do
        manager.execute(task, params)
        expect(application_spy).to have_received(:invoke_task).with("#{task.name}[#{params.join(',')}]")
      end

      it 'updates task to done' do
        expect { manager.execute(task, params) }.to change(task.reload, :done).from(false).to(true)
      end
    end

    context 'without params' do
      it 'executes rake task' do
        manager.execute(task)
        expect(application_spy).to have_received(:invoke_task).with(task.name)
      end

      it 'updates task to done' do
        expect { manager.execute(task) }.to change(task.reload, :done).from(false).to(true)
      end
    end
  end
end
