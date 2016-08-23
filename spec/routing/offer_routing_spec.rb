require 'rails_helper'

describe OffersController do
  describe 'routing' do
    it 'routes to #offer' do
      expect(get: 'offer/MAC0110').to route_to('offers#offer', code: 'MAC0110')
    end
  end
end
