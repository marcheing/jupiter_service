require 'rails_helper'

describe 'Factories' do
  let(:number_of_instances) { 2 }

  FactoryGirl.factories.map(&:name).each do |factory_name|
    describe "#{factory_name} factory" do
      it 'allows for building multiple instances' do
        build_list(factory_name, number_of_instances).each do |built_instance|
          expect(built_instance).to be_valid
        end
      end

      it 'allows for creating multiple instances' do
        create_list(factory_name, number_of_instances).each do |created_instance|
          expect(created_instance).to be_valid
        end
      end
    end
  end
end
