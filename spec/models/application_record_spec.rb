require 'rails_helper'

describe ApplicationRecord do
  describe 'as_json' do
    context 'with a subclass that defines an id field' do
      let!(:the_subclass) { Professor }
      let(:object) { create :professor }
      let(:object_attributes) { attributes_for(:professor).with_indifferent_access }

      it 'adds :id, :created_at and :updated_at to the list of exceptions' do
        object_as_json = object.as_json.with_indifferent_access
        expect(object_as_json.keys).to_not include('id')
        expect(object_as_json.keys).to_not include('created_at')
        expect(object_as_json.keys).to_not include('updated_at')
        object_attributes.each do |attribute, value|
          expect(object_as_json[attribute]).to eq value
        end
      end
    end
  end
end
