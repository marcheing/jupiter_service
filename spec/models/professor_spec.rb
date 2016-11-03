require 'rails_helper'

describe Professor do
  describe 'associations' do
    it { is_expected.to have_many(:schedules) }
    it { is_expected.to have_many(:didactic_activities) }
  end
end
