class Offer < ApplicationRecord
  belongs_to :course
  has_many :schedules
  has_many :didactic_activities
  has_many :subscriptions

  def as_json(options = {})
    options[:except] ||= []
    options[:except] |= [:course_id]
    options[:methods] ||= []
    options[:methods] |= [:subscriptions, :course]
    %w(schedules didactic_activities).each do |method|
      options[:methods] |= [method.to_sym] unless send(method).empty?
    end
    super(options)
  end
end
