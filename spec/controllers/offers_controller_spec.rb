require 'rails_helper'

describe OffersController do
  describe 'offer' do
    it 'returns an offer' do
      get :offer, params: { code: 'MAC0110' }
    end
  end
end
