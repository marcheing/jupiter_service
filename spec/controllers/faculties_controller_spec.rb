require 'rails_helper'

describe FacultiesController do
  let(:ime) do
    Faculty.new.tap do |f|
      f.code = 45
      f.name = 'Instituto de Matemática e Estatística'
      f.campus = 'São Paulo - Cidade Universitária "Armando de Salles Oliveira"'
    end
  end

  describe 'all_faculties' do
    let(:poli) do
      Faculty.new.tap do |f|
        f.code = 3
        f.name = 'Escola Politécnica'
        f.campus = 'São Paulo - Cidade Universitária "Armando de Salles Oliveira"'
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
    it 'returns the faculty info with the passed code' do
      VCR.use_cassette 'faculties/ime_usp_20162' do
        get :single_faculty, params: { code: 45 }

        response_body = JSON.parse response.body
        expect(response_body['code']).to eq ime.code
        expect(response_body['name']).to eq ime.name
        expect(response_body['campus']).to eq ime.campus
      end
    end
  end
end
