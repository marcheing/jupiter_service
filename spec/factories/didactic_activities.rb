FactoryGirl.define do
  factory :didactic_activity do
    workload_hours 2
    activity_type 'type'
    association :professor, factory: :professor, strategy: :build
    association :offer, factory: :offer, strategy: :build
  end
end
