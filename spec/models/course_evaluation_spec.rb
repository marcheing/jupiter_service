require 'rails_helper'

describe CourseEvaluation do
  describe 'associations' do
    it { is_expected.to belong_to(:course) }
  end
end
