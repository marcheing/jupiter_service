require 'rails_helper'

describe Subscription do
  describe 'associations' do
    it { is_expected.to belong_to(:offer) }
  end
end
