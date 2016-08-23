module Jupiter
  module Parser
    class ParserError < StandardError
      def initialize(message = 'Unspecified Parser Error')
        super message
      end
    end
  end
end
