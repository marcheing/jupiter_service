module Jupiter
  module Parser
    class FacultyParser < Base
      attr_reader :faculties, :other_entities

      def self.setting_key
        :faculties
      end

      def response_hash
        successful? ? success_hash : failure_hash
      end

      private

      def success_hash
        {
          faculties: @faculties,
          other_entities: @other_entities
        }
      end

      def failure_hash
        { errors: @errors }
      end

      def parse
        @faculties = create_faculties_list_with_xpath_setting :main_table
        @other_entities = create_faculties_list_with_xpath_setting :other_entities_table
        success
      rescue ParserError => error
        failure(error.message)
      end

      def get_faculties_from_table(table)
        table.map { |row| create_faculty(row) }
      end

      def create_faculties_list_with_xpath_setting(xpath_setting)
        table = table_rows_ignoring_column_name_row settings[self.class.setting_key][xpath_setting]
        get_faculties_from_table table
      end

      def create_faculty(row)
        fields = row.xpath('td')
        Faculty.new.tap do |faculty|
          faculty.code = element_text_at_xpath(fields[0], 'font/span').to_i
          faculty.name = element_text_at_xpath(fields[1], 'font/span/a')
        end
      end
    end
  end
end
