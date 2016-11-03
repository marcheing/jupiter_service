require 'rails_helper'

describe Schedule do
  describe 'associations' do
    it { is_expected.to belong_to(:professor) }
  end

  describe 'as_json' do
    subject { build(:schedule) }

    it 'adds the professor and removes the professor_id' do
      result = subject.as_json
      expect(result.keys).to_not include('professor_id')
      expect(result['professor']).to eq subject.professor
    end
  end
end
