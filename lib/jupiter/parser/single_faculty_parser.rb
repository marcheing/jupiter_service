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
        create_faculty
        success
      rescue ParserError => error
        failure(error.message)
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
