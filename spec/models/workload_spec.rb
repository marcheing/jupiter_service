require 'rails_helper'

describe Workload do
  describe 'associations' do
    it { is_expected.to belong_to(:cycle) }
  end
end
