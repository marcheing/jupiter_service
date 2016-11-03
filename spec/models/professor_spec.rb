require 'rails_helper'

describe Professor do
  describe 'associations' do
    it { is_expected.to have_many(:schedules) }
    it { is_expected.to have_many(:didactic_activities) }
    it { is_expected.to have_and_belong_to_many(:courses) }
  end
end
