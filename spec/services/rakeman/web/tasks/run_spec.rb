# frozen_string_literal: true

RSpec.describe Rakeman::Web::Tasks::Run, type: :service do
  subject(:service) { described_class.new(params) }

  let(:task) { create(:rake_task) }
  let(:parameter) { create(:rakeman_task_parameter, task: task) }
  let(:manager) { instance_double('manager') }

  let(:parameter_value) { Faker::Number.number }

  before do
    service.instance_variable_set(:@manager, manager)
    allow(manager).to receive(:execute)
  end

  describe 'success' do
    let(:params) do
      ActionController::Parameters.new(
        id: task.id,
        task_parameters: {
          parameter.id.to_s => parameter_value
        }
      )
    end

    let(:expected_passed_parameters) { [parameter_value] }

    it 'executes task with a parameter' do
      expect(service.call).to be_success
      expect(manager).to have_received(:execute).with(task, expected_passed_parameters)
    end
  end

  describe 'failure' do
    let(:params) do
      ActionController::Parameters.new(
        id: task.id,
        task_parameters: {
          parameter.id.next.to_s => parameter_value
        }
      )
    end

    let(:result) { service.call }

    it 'does NOT execute task' do
      expect(result).to be_failure
      expect(result.message).to eq I18n.t('rakeman.task_parameters.not_found')
      expect(manager).not_to have_received(:execute)
    end
  end
end
