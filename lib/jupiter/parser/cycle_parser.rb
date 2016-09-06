module Jupiter
  module Parser
    class CycleParser < Base
      attr_reader :cycle

      def initialize(doc, codcg, codcur, codhab)
        @codcg = codcg
        @codcur = codcur
        @codhab = codhab
        super(doc)
      end

      def self.setting_key
        :cycle
      end

      def response_hash
        successful? ? success_hash : failure_hash
      end

      private

      def success_hash
        { cycle: @cycle }
      end

      def failure_hash
        { errors: @errors }
      end

      def parse
        @cycle = Cycle.new.tap do |c|
          c.codcur = @codcur
          c.codhab = @codhab
          c.name = element_text_at_xpath(@doc, settings[self.class.setting_key][:name])
          c.start_date = Date.parse element_text_at_xpath(@doc, settings[self.class.setting_key][:start_date])
          c.ideal_duration = element_text_at_xpath(@doc, settings[self.class.setting_key][:ideal_duration])
          c.minimum_duration = element_text_at_xpath(@doc, settings[self.class.setting_key][:minimum_duration])
          c.maximum_duration = element_text_at_xpath(@doc, settings[self.class.setting_key][:maximum_duration])
          c.workload = parse_workload(table_rows_ignoring_column_name_row(settings[self.class.setting_key][:workload_table]))
          c.specific_information = element_text_at_xpath(@doc, settings[self.class.setting_key][:specific_information])
        end
        success
      rescue ParserError => error
        failure(error.message)
      end

      def parse_workload(table)
        Workload.new.tap do |w|
          w.mandatory = parse_workload_row(table.first)
          w.optional = parse_workload_row(table[1])
          w.elective = parse_workload_row(table[2])
          w.total = parse_workload_row(table.last)
        end
      end

      def parse_workload_row(row)
        workload_data = {}
        fields = row.xpath('td')
        p fields
        workload_data[:category] = element_text_at_xpath(fields[0], 'font/span')
        workload_data[:class] = element_text_at_xpath(fields[1], 'font/span')
        workload_data[:work] = element_text_at_xpath(fields[2], 'font/span')
        workload_data[:total] = element_text_at_xpath(fields[3], 'font/span')
        workload_data[:extra] = element_text_at_xpath(fields[4], 'font/span') unless fields.size < 5
        workload_data
      end
    end
  end
end
