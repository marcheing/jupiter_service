require 'rails_helper'

describe FacultiesController do
  let(:ime) do
    build(:faculty,
      code: 45,
      name: 'Instituto de Matemática e Estatística',
      campus: 'São Paulo - Cidade Universitária "Armando de Salles Oliveira"')
  end

  describe 'all_faculties' do
    let(:poli) do
      build(:faculty,
        code: 3,
        name: 'Escola Politécnica',
        campus: 'São Paulo - Cidade Universitária "Armando de Salles Oliveira"')
    end

    let(:other_entity) do
      build(:faculty,
        code: 30,
        name: 'Centro de Biologia Marinha',
        campus: nil)
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
