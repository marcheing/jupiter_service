require 'rails_helper'

describe CyclesController do
  describe 'routing' do
    it 'routes to #cycle' do
      expect(get: 'cycles/86').to route_to('cycles#cycles', code: '86')
    end
  end
end
