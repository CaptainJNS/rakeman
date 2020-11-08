# frozen_string_literal: true

RSpec.describe Rakeman::Manager do
  let(:manager) { described_class.new }

  describe '#execute' do
    let(:task) { create(:rake_task) }

    before do
      allow(manager).to receive(:`).with("rake #{task.name}").and_return(true)
    end

    it 'executes rake task' do
      manager.execute(task)
      expect(manager).to have_received(:`).with("rake #{task.name}")
    end

    it 'updates task to done' do
      expect { manager.execute(task) }.to change(task.reload, :done).from(false).to(true)
    end
  end
end
