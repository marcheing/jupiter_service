FactoryGirl.define do
  factory :offer do
    start_date Date.parse '01/01/2000'
    end_date Date.parse '02/01/2000'
    class_type 'Teórica'
    class_code '2000145'
    observations 'None'
    association :course, factory: :course, strategy: :build

    trait :with_schedules do
      after(:build) do |offer|
        offer.schedules = build_list(:schedule, 2)
      end
    end

    trait :with_didactic_activities do
      after(:build) do |offer|
        offer.didactic_activities = build_list(:didactic_activity, 2)
      end
    end
  end
end
