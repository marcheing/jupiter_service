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
        get :cycles, code: faculty_code

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

    it 'returns a cycle' do
      VCR.use_cassette "cycle/codcg#{codcg}codcur#{codcur}codhab#{codhab}" do
        get :cycle, params: { codcg: codcg, codcur: codcur, codhab: codhab }

        response_body = JSON.parse response.body
        p response_body
      end
    end
  end
end
