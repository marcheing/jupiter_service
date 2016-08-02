require 'jupiter/client'
require 'jupiter/jupiter_error'

module Jupiter
  ENDPOINTS = {
    faculties: 'jupColegiadoLista'.freeze
  }.freeze

  PARAMETERS = {
    faculties: { tipo: 'D' }.freeze
  }.freeze

  def self.new
    JupiterClient.new
  end
end
