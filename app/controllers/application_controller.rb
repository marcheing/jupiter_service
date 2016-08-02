require 'jupiter'

class ApplicationController < ActionController::API
  def client
    @client ||= Jupiter::Client.new
  end
end
