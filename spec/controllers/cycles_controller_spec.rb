require 'rails_helper'

describe CyclesController do
  describe 'cycles' do
    let(:faculty_code) { 86 }
    let(:befs) do
      Cycle.new.tap do |c|
        c.name = 'Bacharelado em Educação Física e Saúde'
        c.period = 'vespertino'
        c.codcur = 86_050
        c.codhab = 203
      end
    end
    let(:mkt_m) do
      Cycle.new.tap do |c|
        c.name = 'Marketing'
        c.period = 'matutino'
        c.codcur = 86_450
        c.codhab = 202
      end
    end
    let(:mkt_n) do
      Cycle.new.tap do |c|
        c.name = 'Marketing'
        c.period = 'noturno'
        c.codcur = 86_450
        c.codhab = 204
      end
    end
    let(:cycles) { [befs, mkt_m, mkt_n] }

    it 'returns a list of cycles' do
      VCR.use_cassette "cycles/cod#{faculty_code}" do
        get :cycles, params: { code: faculty_code }

        response_body = JSON.parse response.body
        cycles.each do |cycle|
          expect(response_body['cycles']).to include(JSON.parse(cycle.to_json))
        end
      end
    end
  end

  describe 'cycle' do
    let(:codcg) { 45 }
    let(:codcur) { 45_052 }
    let(:codhab) { 1 }
    let(:cycle_name) { 'Bacharelado em Ciência da Computação' }
    let(:observations) { 'Reformulação curricular' }
    let(:start_date) { JSON.parse(Date.parse('01/01/2016').to_json) }
    let(:ideal_duration) { '8 semestres' }
    let(:minimum_duration) { '8 semestres' }
    let(:maximum_duration) { '12 semestres' }

    it 'returns a cycle' do
      VCR.use_cassette "cycle/codcg#{codcg}codcur#{codcur}codhab#{codhab}" do
        get :cycle, params: { codcg: codcg, codcur: codcur, codhab: codhab }

        response_body = JSON.parse response.body
        cycle = response_body['cycle']
        expect(cycle['name']).to eq cycle_name
        expect(cycle['observations']).to eq observations
        expect(cycle['start_date']).to eq start_date
        expect(cycle['ideal_duration']).to eq ideal_duration
        expect(cycle['minimum_duration']).to eq minimum_duration
        expect(cycle['maximum_duration']).to eq maximum_duration
      end
    end
  end
end
