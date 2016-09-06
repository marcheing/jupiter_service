class CyclesController < ApplicationController
  def cycles
    code = params[:code].to_i
    doc = client.cycles(code)
    parser = Jupiter::Parser::CyclesParser.new(doc)
    render json: parser.response_hash, status: parser.successful? ? :ok : :unprocessable_entity
  end

  def cycle
    parameters = cycle_params.map(&:to_i)
    codcg = parameters.first
    codcur = parameters.second
    codhab = parameters.third
    doc = client.cycle(codcg, codcur, codhab)
    parser = Jupiter::Parser::CycleParser.new(doc, codcg, codcur, codhab)
    render json: parser.response_hash, status: parser.successful? ? :ok : :unprocessable_entity
  end

  private

  def cycle_params
    params.require([:codcg, :codcur, :codhab])
  end
end
