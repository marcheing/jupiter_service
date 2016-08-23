class FacultiesController < ApplicationController
  def all_faculties
    doc = client.faculties
    parser = Jupiter::Parser::FacultyParser.new(doc)
    render json: parser.response_hash, status: parser.successful? ? :ok : :unprocessable_entity
  end

  def single_faculty
    code = params[:code]
  end
end
