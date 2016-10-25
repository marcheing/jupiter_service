require 'rails_helper'

describe Professor do
  describe 'associations' do
    it { is_expected.to have_many(:schedules) }
  end
end
