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
        @schedules = []
        # the first row contains the field names, so it's discarded
        schedule_data = @doc.xpath('tr')[1..-1]
        schedule_data.each do |row|
          schedule = create_schedule(row)
          schedule.day = @schedules.last.day if schedule.day.blank?
          schedule.start_time = @schedules.last.start_time if schedule.start_time.blank?
          schedule.end_time = @schedules.last.end_time if schedule.end_time.blank?
          schedules << schedule
        end
      end

      def create_schedule(row)
        schedule = Schedule.new
        fields = row.xpath('td')
        schedule.day = fields[0].at_xpath('font/span').text.strip
        schedule.start_time = fields[1].at_xpath('font/span').text.strip
        schedule.end_time = fields[2].at_xpath('font/span').text.strip
        schedule.professor = fields[3].at_xpath('font/span').text.strip
        schedule
      end
    end
  end
end
