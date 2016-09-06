require 'rails_helper'

describe CyclesController do
  describe 'routing' do
    it 'routes to #cycles' do
      expect(get: 'cycles/86').to route_to('cycles#cycles', code: '86')
    end

    it 'routes to #cycle' do
      expect(get: 'cycle').to route_to('cycles#cycle')
    end
  end
end
