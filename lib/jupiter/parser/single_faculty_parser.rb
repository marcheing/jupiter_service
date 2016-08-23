module Jupiter
  module Parser
    class SingleFacultyParser < Base
      attr_reader :faculty

      def initialize(doc, code)
        @code = code
        super(doc)
      end

      def self.setting_key
        :single_faculty
      end

      def response_hash
        successful? ? success_hash : failure_hash
      end

      private

      def success_hash
        {
          code: @faculty.code,
          name: @faculty.name,
          campus: @faculty.campus
        }
      end

      def failure_hash
        { errors: @errors }
      end

      def parse
        check_for_cycles
        create_faculty
        success
      rescue ParserError => error
        failure(error.message)
      end

      def check_for_cycles
        warning = parse_field(:warning_message)
        return if warning.empty?
        if /#{settings[:there_is_no_cycle]}/ =~ warning
          raise ParserError, "No cycle found for faculty with code: #{@code}"
        else
          raise ParserError, "The page gave a warning: #{warning}"
        end
      end

      def create_faculty
        @faculty = Faculty.new.tap do |f|
          f.code = @code
          f.name = parse_field(:name)
          f.campus = parse_field(:campus).split('Campus: ').last
        end
      end
    end
  end
end
