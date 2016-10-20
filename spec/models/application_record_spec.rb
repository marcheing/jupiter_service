require 'rails_helper'

describe ApplicationRecord do
  describe 'as_json' do
    context 'with a subclass that defines an id field' do
      let!(:the_subclass) { Professor }
      let(:object) { build :professor }
      let(:object_attributes) { attributes_for(:professor).with_indifferent_access }

      it 'adds the :id to the list of exceptions' do
        object_as_json = object.as_json.with_indifferent_access
        expect(object_as_json.keys).to_not include('id')
        object_attributes.each do |attribute, value|
          expect(object_as_json[attribute]).to eq value
        end
      end
    end
  end
end
