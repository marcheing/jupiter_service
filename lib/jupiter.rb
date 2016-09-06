require 'jupiter/client'
require 'jupiter/jupiter_error'
require 'jupiter/parser'

module Jupiter
  ENDPOINTS = {
    faculties: 'jupColegiadoLista'.freeze,
    single_faculty: 'jupCursoLista'.freeze,
    offers: 'obterTurma'.freeze,
    cycles: 'jupCursoLista'.freeze,
    cycle: 'listarGradeCurricular'.freeze
  }.freeze

  PARAMETERS = {
    faculties: { tipo: 'D' }.freeze,
    single_faculty: { tipo: 'N' }.freeze,
    cycles: { tipo: 'N' }.freeze,
    cycle: { tipo: 'N' }.freeze
  }.freeze

  def self.new
    JupiterClient.new
  end
end
