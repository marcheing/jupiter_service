class CourseEvaluation < ApplicationRecord
  belongs_to :course

  def as_json(options = {})
    options[:except] ||= []
    options[:except] |= [:course_id]
    super(options)
  end
end
