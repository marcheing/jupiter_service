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
      let(:first_schedule_professor) { 'Alfredo Goldman Vel Lejbman' }
      let(:first_subscription_type) { 'Obrigatória' }
      let(:first_subscription_vacancy) { 70 }
      let(:first_subscription_subscribed) { 82 }
      let(:first_subscription_pending) { 31 }
      let(:first_subscription_enrolled) { 38 }
      let(:second_subscription_assignment) { 'IME - Matemática Licenciatura Noturno' }
      let(:second_subscription_type) { first_subscription_type }

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
          expect(offers.first['subscriptions'].first['type']).to match first_subscription_type
          expect(offers.first['subscriptions'].first['assigned_to']).to be_nil
          expect(offers.first['subscriptions'].first['vacancy']).to eq first_subscription_vacancy
          expect(offers.first['subscriptions'].first['subscribed']).to eq first_subscription_subscribed
          expect(offers.first['subscriptions'].first['pending']).to eq first_subscription_pending
          expect(offers.first['subscriptions'].first['enrolled']).to eq first_subscription_enrolled
          expect(offers.first['subscriptions'].second['type']).to match second_subscription_type
          expect(offers.first['subscriptions'].second['assigned_to']).to match second_subscription_assignment
          expect(offers.second['subscriptions'].size).to eq 5
        end
      end
    end
  end
end
