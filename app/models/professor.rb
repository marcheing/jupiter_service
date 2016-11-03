class Professor < ApplicationRecord
  has_many :schedules
  has_many :didactic_activities
  has_and_belongs_to_many :courses
end
