module Jupiter
  module Parser
    class Base
      attr_accessor :doc
      attr_reader :state, :errors

      INITIAL_STATE = :initial
      SUCCESSFUL_STATE = :successful
      UNSUCCESSFUL_STATE = :unsuccessful

      def self.setting_key
        raise NotImplementedError
      end

      def initialize(doc)
        @doc = doc
        @state = INITIAL_STATE
        @errors = []
        parse
      end

      def successful?
        @state == SUCCESSFUL_STATE
      end

      protected

      def success
        @state = SUCCESSFUL_STATE
      end

      def failure(message = '')
        @state = UNSUCCESSFUL_STATE
        @errors << message
      end

      private

      def parse_field(field, element = @doc)
        element_text_at_xpath(element, settings[self.class.setting_key][field])
      end

      def settings
        ParserSettings.to_h.with_indifferent_access
      end

      def element_text_at_xpath(element, xpath)
        child_element = element.at_xpath(xpath)
        return '' if child_element.nil?
        child_element.text.strip
      end
    end
  end
end
