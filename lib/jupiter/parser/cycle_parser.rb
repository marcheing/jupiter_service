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
          parse_text_fields c
          c.courses_by_category = parse_courses(@doc.xpath(settings_at_key(:courses_table)))
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
        workload_data[:category] = element_text_at_xpath(fields[0], 'font')
        workload_data[:class] = element_text_at_xpath(fields[1], 'font')
        workload_data[:work] = element_text_at_xpath(fields[2], 'font')
        workload_data[:total] = element_text_at_xpath(fields[3], 'font')
        workload_data[:extra] = element_text_at_xpath(fields[4], 'font') unless fields.size < 5
        workload_data
      end

      def parse_text_fields(cycle)
        cycle.name = element_text_at_xpath(@doc, settings_at_key(:name))
        cycle.start_date = Date.parse element_text_at_xpath(@doc, settings_at_key(:start_date))
        cycle.ideal_duration = element_text_at_xpath(@doc, settings_at_key(:ideal_duration))
        cycle.minimum_duration = element_text_at_xpath(@doc, settings_at_key(:minimum_duration))
        cycle.maximum_duration = element_text_at_xpath(@doc, settings_at_key(:maximum_duration))
        cycle.workload = parse_workload(table_rows_ignoring_column_name_row(settings_at_key(:workload_table)))
        cycle.specific_information = element_formatted_text_at_xpath(@doc, settings_at_key(:specific_information))
        cycle.observations = element_text_at_xpath(@doc, settings_at_key(:observations_text))
      end

      def parse_courses(rows)
        courses_hash = {}
        category = term = ''
        rows.each do |row|
          columns = row.xpath('td')
          first_column = columns.first
          if columns.size == 1
            category = element_text_at_xpath(first_column, '*')
            courses_hash[category] = {}
            next
          elsif row['bgcolor'] == '#CCCCCC'
            term = element_text_at_xpath(first_column, 'font/span')
            courses_hash[category][term] = []
            next
          else
            course = element_text_at_xpath(first_column, 'a')
            courses_hash[category][term] << course unless course.empty?
          end
        end
        courses_hash
      end
    end
  end
end
