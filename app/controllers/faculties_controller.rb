class FacultiesController < ApplicationController
  def read_faculties
    doc = client.faculties
    render json: { faculties: doc.css('a[class=link_gray]').map(&:text) }
  end
end
