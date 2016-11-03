require 'rails_helper'

describe Cycle do
  describe 'associations' do
    it { is_expected.to have_one(:workload) }
  end
end
