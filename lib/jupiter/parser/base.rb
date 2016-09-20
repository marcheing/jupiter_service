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

      def settings_at_key(key)
        settings[self.class.setting_key][key]
      end

      def element_formatted_text_at_xpath(element, xpath)
        child_element = element.at_xpath(xpath)
        return '' if child_element.nil?
        child_element.css('br').each { |br| br.replace "\n" }
        child_element.text.strip
      end

      def element_text_at_xpath(element, xpath)
        child_element = element.at_xpath(xpath)
        return '' if child_element.nil?
        child_element.text.gsub(/\p{Space}/, ' ').strip.squeeze(' ')
      end

      def table_rows_ignoring_column_name_row(table_xpath)
        @doc.xpath(table_xpath)[1..-1]
      end
    end
  end
end
