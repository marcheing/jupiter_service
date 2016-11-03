require 'rails_helper'

describe IdealTerm do
  describe 'associations' do
    it { is_expected.to belong_to(:course) }
    it { is_expected.to belong_to(:cycle) }
  end
end
