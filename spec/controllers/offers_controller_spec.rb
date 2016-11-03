require 'rails_helper'

describe OffersController do
  describe 'offer' do
    context 'MAC0110 from 2016, 2nd term' do
      let(:faculty) { 'Instituto de Matemática e Estatística' }
      let(:cycle_name) { 'Ciência da Computação' }
      let(:course) { 'Introdução à Computação' }
      let(:first_schedule_day) { 'ter' }
      let(:first_schedule_start_time) { '21:10' }
      let(:first_schedule_end_time) { '22:50' }
      let(:first_schedule_professor) { JSON.parse build(:professor, code: nil, name: 'Alfredo Goldman Vel Lejbman').to_json }
      let(:first_subscription_kind) { 'Obrigatória' }
      let(:first_subscription_vacancy) { 70 }
      let(:first_subscription_subscribed) { 82 }
      let(:first_subscription_pending) { 31 }
      let(:first_subscription_enrolled) { 38 }
      let(:second_subscription_assignment) { 'IME - Matemática Licenciatura Noturno' }
      let(:second_subscription_kind) { first_subscription_kind }

      it 'returns the offers from the page' do
        VCR.use_cassette 'offers/mac0110_20162' do
          get :offer, params: { code: 'MAC0110' }

          response_body = JSON.parse response.body
          offers = response_body['offers']
          expect(response_body['faculty_name']).to match faculty
          expect(response_body['cycle_name']).to match cycle_name
          expect(response_body['course']).to match course
          expect(offers.size).to eq 2
          expect(offers.first['schedules'].size).to eq 2
          expect(offers.first['schedules'].first['day']).to match first_schedule_day
          expect(offers.first['schedules'].first['start_time']).to match first_schedule_start_time
          expect(offers.first['schedules'].first['end_time']).to match first_schedule_end_time
          expect(offers.first['schedules'].first['professor']).to match first_schedule_professor
          expect(offers.first['subscriptions'].size).to eq 4
          expect(offers.first['subscriptions'].first['kind']).to match first_subscription_kind
          expect(offers.first['subscriptions'].first['assigned_to']).to be_nil
          expect(offers.first['subscriptions'].first['vacancy']).to eq first_subscription_vacancy
          expect(offers.first['subscriptions'].first['subscribed']).to eq first_subscription_subscribed
          expect(offers.first['subscriptions'].first['pending']).to eq first_subscription_pending
          expect(offers.first['subscriptions'].first['enrolled']).to eq first_subscription_enrolled
          expect(offers.first['subscriptions'].second['kind']).to match second_subscription_kind
          expect(offers.first['subscriptions'].second['assigned_to']).to match second_subscription_assignment
          expect(offers.second['subscriptions'].size).to eq 5
        end
      end
    end

    context 'ACH0042 from 2016, 2nd term' do
      let(:schedule_day) { 'seg' }
      let(:schedule_start_time) { '08:00' }
      let(:schedule_end_time) { '12:00' }
      let(:schedule_professor_1) { JSON.parse build(:professor, code: nil, name: 'Diamantino Alves Correia Pereira').to_json }
      let(:schedule_professor_2) { JSON.parse build(:professor, code: nil, name: 'Dominique Mouette').to_json }
      let(:schedule_professor_3) { JSON.parse build(:professor, code: nil, name: 'Fabio Campos').to_json }

      it 'correctly parsers the professors on the schedules' do
        VCR.use_cassette 'offers/ach0042_20162' do
          get :offer, params: { code: 'ACH0042' }

          response_body = JSON.parse response.body
          offers = response_body['offers']
          expect(offers.first['schedules'].size).to eq 3
          expect(offers.first['schedules'].first['professor']).to eq schedule_professor_1
          expect(offers.first['schedules'].second['professor']).to eq schedule_professor_2
          expect(offers.first['schedules'].last['professor']).to eq schedule_professor_3
        end
      end
    end

    context 'ACH0162 from 2016, 2nd term' do
      let(:schedule_day) { 'ter' }
      let(:schedule_start_time) { '08:00' }
      let(:schedule_end_time) { '09:45' }
      let(:schedule_professor_1) { JSON.parse build(:professor, code: nil, name: 'Marilia Velardi').to_json }

      let(:fifth_offer_class_code) { '2016232' }
      let(:fifth_offer_start_date) { '01/08/2016' }
      let(:fifth_offer_end_date) { '10/12/2016' }

      it 'correctly parses the page' do
        VCR.use_cassette 'offers/ach0162_20162' do
          get :offer, params: { code: 'ACH0162' }

          response_body = JSON.parse response.body
          offers = response_body['offers']
          expect(offers.first['schedules'].size).to eq 1
          expect(offers.first['schedules'].first['start_time']).to eq schedule_start_time
          expect(offers.first['schedules'].first['end_time']).to eq schedule_end_time
          expect(offers.first['schedules'].first['professor']).to eq schedule_professor_1

          # The fifth offer should not have schedules
          expect(offers[4]['schedules']).to be_nil
          expect(offers[4]['subscriptions']).to_not be_nil
          expect(offers[4]['class_code']).to eq fifth_offer_class_code
          expect(offers[4]['start_date']).to eq fifth_offer_start_date
          expect(offers[4]['end_date']).to eq fifth_offer_end_date
        end
      end
    end

    context 'CMU0402 from 2016, 2nd term' do
      let(:professor) { 'Francisco José da Silva Campos Neto (R)' }
      let(:activity_type) { 'Aulas Práticas com Horário Variável' }
      let(:workload) { 15 }

      it 'correctly parses the page and adds didactic activities instead of schedules' do
        VCR.use_cassette 'offers/cmu0402_20162' do
          get :offer, params: { code: 'CMU0402' }

          response_body = JSON.parse response.body
          offers = response_body['offers']
          expect(offers.first['schedules']).to be_nil
          expect(offers.first['didactic_activities'].size).to eq 1
          expect(offers.first['didactic_activities'].first['professor']['name']).to eq professor
          expect(offers.first['didactic_activities'].first['activity_type']).to eq activity_type
          expect(offers.first['didactic_activities'].first['workload_hours']).to eq workload
        end
      end
    end

    context 'course without offer' do
      it 'responds with unprocessable entity' do
        VCR.use_cassette 'offers/mac2166_20162' do
          get :offer, params: { code: 'MAC2166' }

          response_body = JSON.parse response.body
          expect(response.status).to eq 422
          errors = response_body['errors']
          expect(errors.first).to match(/No offer associated/)
        end
      end
    end
  end
end
