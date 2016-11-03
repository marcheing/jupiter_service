module Jupiter
  module Parser
    class DidacticActivityParser < Base
      attr_reader :didactic_activities

      private

      def parse
        create_didactic_activities
      end

      def create_didactic_activities
        @didactic_activities = []
        # the first row contains the table's name
        # the second row contains the table's column names
        didactic_activity_data = @doc.xpath('tr')[2..-1]
        didactic_activity_data.each do |row|
          didactic_activity = create_didactic_activity(row)
          didactic_activities << didactic_activity
        end
      end

      def create_didactic_activity(row)
        fields = row.xpath('td')
        professor_name = element_text_at_xpath(fields[0], 'font/span')
        type = element_text_at_xpath(fields[1], 'font/span')
        workload = element_text_at_xpath(fields[2], 'font/span').to_i
        DidacticActivity.find_or_create_by(professor: Professor.find_or_create_by(name: professor_name), activity_type: type, workload_hours: workload)
      end
    end
  end
end
