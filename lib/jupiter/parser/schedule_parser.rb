module Jupiter
  module Parser
    class ScheduleParser < Base
      attr_reader :schedules

      private

      def parse
        create_schedules
      end

      def create_schedules
        @schedules = []
        # the first row contains the field names, so it's discarded
        schedule_data = table_rows_ignoring_column_name_row('tr')
        schedule_data.each do |row|
          schedule = create_schedule(row)
          schedule.day = @schedules.last.day if schedule.day.blank?
          schedule.start_time = @schedules.last.start_time if schedule.start_time.blank?
          schedule.end_time = @schedules.last.end_time if schedule.end_time.blank?
          schedules << persist_schedule(schedule)
        end
      end

      def create_schedule(row)
        fields = row.xpath('td')
        Schedule.new.tap do |s|
          s.day = element_text_at_xpath(fields[0], 'font/span')
          s.start_time = element_text_at_xpath(fields[1], 'font/span')
          s.end_time = element_text_at_xpath(fields[2], 'font/span')
          s.professor = Professor.find_or_create_by(name: element_text_at_xpath(fields[3], 'font/span'))
        end
      end

      def persist_schedule(schedule)
        Schedule.find_or_create_by(day: schedule.day, start_time: schedule.start_time, end_time: schedule.end_time, professor: schedule.professor)
      end
    end
  end
end
