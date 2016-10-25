FactoryGirl.define do
  factory :schedule do
    day 'ter'
    start_time '10:20'
    end_time '10:21'
    association :professor, factory: :professor, strategy: :build
  end
end
