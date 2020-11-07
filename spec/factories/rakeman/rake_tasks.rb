# frozen_string_literal: true

FactoryBot.define do
  factory :rake_task, class: 'Rakeman::RakeTask' do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
  end
end
