require 'rails_helper'

describe CourseWorkload do
  describe 'associations' do
    it { is_expected.to belong_to(:course) }
  end
end
