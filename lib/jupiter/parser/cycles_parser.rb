module Jupiter
  module Parser
    class CyclesParser < Base
      attr_reader :cycles

      def self.setting_key
        :cycles
      end

      def response_hash
        successful? ? success_hash : failure_hash
      end

      private

      def success_hash
        { cycles: @cycles }
      end

      def failure_hash
        { errors: @errors }
      end

      def parse
        cycles_table = table_rows_ignoring_column_name_row(settings[self.class.setting_key][:cycles_table])
        @cycles = get_cycles_from_table(cycles_table)
        success
      rescue ParserError => error
        failure(error.message)
      end

      def get_cycles_from_table(table)
        table.map do |row|
          fields = row.xpath('td')
          name = element_text_at_xpath(fields[0], 'font/span')
          period = element_text_at_xpath(fields[1], 'font/span')
          codes = parse_codes fields[0].at_xpath('font/span/a')['href']
          codcur = codes[:codcur].to_i
          codhab = codes[:codhab].to_i
          Cycle.find_or_create_by(name: name, period: period, codcur: codcur, codhab: codhab)
        end
      end

      def parse_codes(cycle_link)
        cycle_link.match(/codcur=(?<codcur>\d+).*codhab=(?<codhab>\d+)/)
      end
    end
  end
end
