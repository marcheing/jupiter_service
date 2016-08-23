module Jupiter
  module Parser
    class ScheduleParser < Base
      attr_reader :schedules

      def initialize(doc)
        @doc = doc
        super()
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
        schedule.day = element_text_at_xpath(fields[0], 'font/span')
        schedule.start_time = element_text_at_xpath(fields[1], 'font/span')
        schedule.end_time = element_text_at_xpath(fields[2], 'font/span')
        schedule.professor = element_text_at_xpath(fields[3], 'font/span')
        schedule
      end
    end
  end
end
