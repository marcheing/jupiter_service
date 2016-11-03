class Professor < ApplicationRecord
  has_many :schedules
  has_many :didactic_activities
end
