module Jupiter
  class Client
    def initialize(use_logger = false)
      @connection = Faraday.new(url: Settings.base_url) do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
        faraday.response :logger if use_logger
      end
    end

    def faculties
      request(ENDPOINTS[:faculties], PARAMETERS[:faculties])
    end

    def offers(code)
      request(ENDPOINTS[:offers], sgldis: code)
    end

    private

    def request(endpoint, parameters = {}, method = :get)
      response = @connection.send(method, endpoint, parameters)
      return Nokogiri::HTML(response.body) if response.status == 200
      raise JupiterError.new("Error while requesting endpoint #{endpoint}", response)
    end
  end
end
