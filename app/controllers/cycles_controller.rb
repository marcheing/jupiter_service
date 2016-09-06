class CyclesController < ApplicationController
  def cycles
    code = params[:code].to_i
    doc = client.cycles(code)
    parser = Jupiter::Parser::CyclesParser.new(doc)
    render json: parser.response_hash, status: parser.successful? ? :ok : :unprocessable_entity
  end
end
