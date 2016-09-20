require 'rails_helper'

describe CoursesController do
  describe 'routing' do
    it 'routes to #course' do
      expect(get: 'course/MAC0110').to route_to('courses#course', code: 'MAC0110')
    end
  end
end
