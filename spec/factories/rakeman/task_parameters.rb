# frozen_string_literal: true

FactoryBot.define do
  factory :rakeman_task_parameter, class: 'Rakeman::TaskParameter' do
    name { Faker::Lorem.word }
    task factory: :rake_task
  end
end
