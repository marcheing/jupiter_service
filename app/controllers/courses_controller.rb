class CoursesController < ApplicationController
  def course
    code = params[:code]
    doc = client.course(code)
    parser = Jupiter::Parser::CourseParser.new(doc, code)
    render json: parser.response_hash, status: parser.successful? ? :ok : :unprocessable_entity
  end
end
