module Jupiter
  module Parser
    class ScheduleParser < Base
      attr_reader :schedules

      def initialize(doc)
        @doc = doc
        parse
      end

      private

      def parse
        create_schedules
      end

      def create_schedules
        # the first row contains the field names
        schedule_data = @doc.xpath('tr')[1..-1]
        schedule_data.each do |row|
          @schedules = []
          create_schedule(row)
        end
      end

      def create_schedule(row)
        schedule = schedule.new
        schedule.professors = []
        fields = row.xpath('td')
        schedule.day = fields[0].at_xpath('font/span').text.strip
        schedule.start_time = fields[1].at_xpath('font/span').text.strip
        schedule.end_time = fields[1].at_xpath('font/span').text.strip

      end
    end
  end
end
