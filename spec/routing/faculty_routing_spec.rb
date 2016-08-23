require 'rails_helper'

describe FacultiesController do
  describe 'routing' do
    it 'routes to #all_faculties' do
      expect(get: 'all_faculties').to route_to('faculties#all_faculties')
    end

    it 'routes to #single_faculty' do
      expect(get: 'faculty/86').to route_to('faculties#single_faculty', code: '86')
    end
  end
end
