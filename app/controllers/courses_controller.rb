class CoursesController < ApplicationController
  def course
    code = params[:code].to_i
    doc = client.course(code)
  end
end
