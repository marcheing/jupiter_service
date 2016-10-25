require 'rails_helper'

describe Schedule do
  describe 'associations' do
    it { is_expected.to belong_to(:professor) }
  end
end
