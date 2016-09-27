require 'rails_helper'

describe CoursesController do
  describe 'course' do
    let(:course_code) { 'MAC0101' }
    let(:course_name) { 'Integração na Universidade e na Profissão' }
    let(:department) { 'Ciência da Computação' }
    let(:faculty) { 'Instituto de Matemática e Estatística' }
    let(:alt_name) { 'Introduction to Computer Science' }
    let(:class_credits) { 2 }
    let(:work_credits) { 0 }
    let(:workload_hours) { 30 }
    let(:period) { 'Semestral' }
    let(:activation_date) { JSON.parse(Date.parse('01/01/2016').to_json) }
    let(:professor_code) { 91_288 }
    let(:professor_name) { 'Carlos Eduardo Ferreira' }
    let(:evaluation_method) { 'Média ponderada de provas e exercícios.' }
    let(:evaluation_criterion) { 'Média ponderada de provas e exercícios.' }
    let(:evaluation_rec) { 'Normas de recuperação: Média ponderada da nota final e de provas e/ou trabalhos de recuperação.' }
    let(:bibliography) { 'Não há.' }

    it 'returns the course information' do
      VCR.use_cassette "courses/#{course_code}" do
        get :course, params: { code: course_code }

        response_body = JSON.parse response.body
        course_hash = response_body['course']
        expect(course_hash['code']).to eq course_code
        expect(course_hash['name']).to eq course_name
        expect(course_hash['department']).to eq department
        expect(course_hash['faculty']).to eq faculty
        expect(course_hash['alt_name']).to eq alt_name
        expect(course_hash['workload']['class_credits']).to eq class_credits
        expect(course_hash['workload']['work_credits']).to eq work_credits
        expect(course_hash['workload']['total']).to eq workload_hours
        expect(course_hash['period']).to eq period
        expect(course_hash['activation_date']).to eq activation_date
        expect(course_hash['bibliography']).to eq bibliography
        expect(course_hash['professors'].first['code']).to eq professor_code
        expect(course_hash['professors'].first['name']).to eq professor_name
        expect(course_hash['evaluation']['method']).to eq evaluation_method
        expect(course_hash['evaluation']['criterion']).to eq evaluation_criterion
        expect(course_hash['evaluation']['rec']).to eq evaluation_rec
      end
    end
  end
end
