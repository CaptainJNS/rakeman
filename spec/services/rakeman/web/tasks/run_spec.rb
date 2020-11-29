# frozen_string_literal: true

RSpec.describe Rakeman::Web::Tasks::Run, type: :service do
  subject(:service) { described_class.new(task, params, manager) }

  let(:task) { create(:rake_task) }
  let(:parameter) { create(:rakeman_task_parameter, task: task) }
  let(:manager) { instance_double('manager') }

  let(:parameter_value) { Faker::Number.number }

  before do
    allow(manager).to receive(:execute).and_return(true)
  end

  describe 'success' do
    let(:params) do
      ActionController::Parameters.new(
        task_parameters: {
          parameter.id.to_s => parameter_value
        }
      )
    end

    let(:expected_passed_parameters) { [parameter_value] }

    it 'executes task with a parameter' do
      expect(service.call).to be_truthy
      expect(manager).to have_received(:execute).with(task, expected_passed_parameters)
    end
  end

  describe 'failure' do
    let(:params) do
      ActionController::Parameters.new(
        task_parameters: {
          parameter.id.next.to_s => parameter_value
        }
      )
    end

    it 'executes task with a parameter' do
      expect(service.call).to be_falsey
      expect(manager).not_to have_received(:execute)
    end
  end
end
