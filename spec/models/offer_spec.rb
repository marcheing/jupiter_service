require 'rails_helper'

describe Offer do
  describe 'associations' do
    it { is_expected.to belong_to(:course) }
    it { is_expected.to have_many(:schedules) }
    it { is_expected.to have_many(:didactic_activities) }
    it { is_expected.to have_many(:subscriptions) }
  end

  describe 'as_json' do
    context 'with schedules' do
      subject { build(:offer, :with_schedules) }

      it 'adds the associated records and removes the course_id' do
        result = subject.as_json
        expect(result.keys).to_not include('course_id')
        expect(result['course']).to eq subject.course
        expect(result['subscriptions']).to eq subject.subscriptions
        expect(result['schedules']).to eq subject.schedules
        expect(result['didactic_activities']).to be_nil
      end
    end

    context 'with didactic_activities' do
      subject { build(:offer, :with_didactic_activities) }

      it 'adds the associated records and removes the course_id' do
        result = subject.as_json
        expect(result.keys).to_not include('course_id')
        expect(result['course']).to eq subject.course
        expect(result['subscriptions']).to eq subject.subscriptions
        expect(result['didactic_activities']).to eq subject.didactic_activities
        expect(result['schedules']).to be_nil
      end
    end
  end
end
