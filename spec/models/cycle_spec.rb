require 'rails_helper'

describe Cycle do
  describe 'associations' do
    it { is_expected.to have_one(:workload) }
    it { is_expected.to have_many(:courses).through(:ideal_terms) }
    it { is_expected.to have_many(:ideal_terms) }
  end
end
