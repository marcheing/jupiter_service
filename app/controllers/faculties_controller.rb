require 'open-uri'

class FacultiesController < ApplicationController
  def read_faculties
    address = 'https://uspdigital.usp.br/jupiterweb/jupColegiadoLista?tipo=D'
    doc = Nokogiri::HTML(open(address))
    render json: { faculties: doc.css('a[class=link_gray]').map(&:text) }
  end
end
