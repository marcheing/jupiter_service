require 'rails_helper'

describe Course do
  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:professors) }
    it { is_expected.to have_one(:course_workload) }
    it { is_expected.to have_many(:cycles).through(:ideal_terms) }
    it { is_expected.to have_many(:ideal_terms) }
  end
end
