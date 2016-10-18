class Offer
  FIELDS = [
    :class_code,
    :start_date,
    :end_date,
    :class_type,
    :observations
  ].freeze

  attr_accessor :schedules, :subscriptions, :didactic_activities, *FIELDS
end
