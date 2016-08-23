require 'rails_helper'

describe FacultiesController do
  describe 'all_faculties' do
    let(:ime) do
      Faculty.new.tap do |f|
        f.code = 45
        f.name = 'Instituto de Matemática e Estatística'
      end
    end

    let(:poli) do
      Faculty.new.tap do |f|
        f.code = 3
        f.name = 'Escola Politécnica'
      end
    end

    let(:other_entity) do
      Faculty.new.tap do |f|
        f.code = 30
        f.name = 'Centro de Biologia Marinha'
      end
    end

    it 'returns a list of faculties' do
      VCR.use_cassette 'faculties/all_faculties' do
        get :all_faculties

        response_body = JSON.parse response.body
        faculties = response_body['faculties']
        other_entities = response_body['other_entities']
        expect(faculties).to include JSON.parse(ime.to_json)
        expect(faculties).to include JSON.parse(poli.to_json)
        expect(other_entities).to include JSON.parse(other_entity.to_json)
      end
    end
  end

  describe 'single_faculty' do
    pending 'single_faculty action' do
      it 'returns the faculty info with the passed code' do
        get :faculty
      end
    end
  end
end
