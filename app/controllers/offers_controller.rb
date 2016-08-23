require 'jupiter'

class OffersController < ApplicationController
  def offer
    doc = client.offers(params[:code])
    parser = Jupiter::Parser::OfferParser.new(doc, params[:code])
    p parser.faculty_name
    p parser.cycle_name
    p parser.course
    p parser.offers
  end
end
