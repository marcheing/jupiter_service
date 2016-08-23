require 'jupiter'

class OffersController < ApplicationController
  def offer
    doc = client.offers(params[:code])
    parser = Jupiter::Parser::OfferParser.new(doc, params[:code])
    render json: parser.response_hash, status: parser.successful? ? :ok : :unprocessable_entity
  end
end
