class Course < ApplicationRecord
  has_one :course_workload
  has_one :course_evaluation
  has_and_belongs_to_many :professors

  alias workload course_workload
  alias workload= course_workload=
  alias evaluation course_evaluation
  alias evaluation= course_evaluation=

  def as_json(options = {})
    options[:methods] ||= []
    options[:methods] |= [:workload, :professors, :evaluation]
    super(options)
  end
end
