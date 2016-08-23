module Jupiter
  module Parser
    class Base
      attr_accessor :doc

      def self.setting_key
        raise NotImplementedError
      end

      private

      def parse_field(field, element = @doc)
        parsed_element = element.at_xpath(settings[self.class.setting_key][field])
        raise if parsed_element.nil?
        parsed_element.text.strip
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
