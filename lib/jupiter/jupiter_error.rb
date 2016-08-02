module Jupiter
  class JupiterError < StandardError
    def initialize(message = 'Unspecified Jupiter Error', response = nil)
      @response = response
      super message
    end
  end
end
