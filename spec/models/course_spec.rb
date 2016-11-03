require 'rails_helper'

describe Course do
  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:professors) }
    it { is_expected.to have_one(:course_workload) }
  end
end
