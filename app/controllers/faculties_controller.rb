class FacultiesController < ApplicationController
  def all_faculties
    parser = Jupiter::Parser::FacultyParser.new(client.faculties)
    render json: parser.response_hash, status: parser.successful? ? :ok : :unprocessable_entity
  end

  def single_faculty
    code = params[:code].to_i
    doc = client.single_faculty(code)
    parser = Jupiter::Parser::SingleFacultyParser.new(doc, code)
    render json: parser.response_hash, status: parser.successful? ? :ok : :unprocessable_entity
  end
end
