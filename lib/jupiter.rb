require 'jupiter/client'
require 'jupiter/jupiter_error'
require 'jupiter/parser'

module Jupiter
  ENDPOINTS = {
    faculties: 'jupColegiadoLista'.freeze,
    offers: 'obterTurma'.freeze
  }.freeze

  PARAMETERS = {
    faculties: { tipo: 'D' }.freeze
  }.freeze

  def self.new
    JupiterClient.new
  end
end
