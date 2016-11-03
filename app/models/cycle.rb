class Cycle < ApplicationRecord
  has_one :workload
  attr_accessor :courses_by_category
end
