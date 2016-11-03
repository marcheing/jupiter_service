class Cycle < ApplicationRecord
  has_one :workload
  has_many :courses, through: :ideal_terms
  has_many :ideal_terms
  attr_accessor :courses_by_category
end
