module Jupiter
  module Parser
    class CourseParser < Base
      attr_reader :course

      def initialize(doc, code)
        @code = code
        super(doc)
      end

      def self.setting_key
        :course
      end

      def response_hash
        successful? ? success_hash : failure_hash
      end

      private

      def success_hash
        { course: @course }
      end

      def failure_hash
        { errors: @errors }
      end

      def parse
        @course = Course.find_by(code: @code)
        if @course.nil?
          @course = Course.new.tap do |c|
            c.code = @code
            parse_simple_text_fields c
            parse_formatted_text_fields c
            c.name = parse_course_name
            c.workload = parse_workload
            c.professors = parse_professors
            c.evaluation = parse_evaluation
          end
          @course.save
        end
        success
      rescue ParserError => error
        failure(error.message)
      end

      def parse_formatted_text_fields(course)
        course.goals = element_formatted_text_at_xpath(@doc, settings_at_key(:goals))
        course.bibliography = element_formatted_text_at_xpath(@doc, settings_at_key(:bibliography))
      end

      def parse_simple_text_fields(course)
        course.faculty = element_text_at_xpath(@doc, settings_at_key(:faculty))
        course.department = element_text_at_xpath(@doc, settings_at_key(:department))
        course.alt_name = element_text_at_xpath(@doc, settings_at_key(:alt_name))
        course.period = element_text_at_xpath(@doc, settings_at_key(:period))
        course.activation_date = Date.parse(element_text_at_xpath(@doc, settings_at_key(:activation)))
        course.syllabus = element_text_at_xpath(@doc, settings_at_key(:syllabus))
        course.short_syllabus = element_text_at_xpath(@doc, settings_at_key(:short_syllabus))
      end

      def parse_course_name
        element_text_at_xpath(@doc, settings_at_key(:name)).split(' - ').last
      end

      def parse_workload
        class_credits = element_text_at_xpath(@doc, settings_at_key(:class_credits)).to_i
        work_credits = element_text_at_xpath(@doc, settings_at_key(:work_credits)).to_i
        total = element_text_at_xpath(@doc, settings_at_key(:total_workload)).to_i
        CourseWorkload.create(class_credits: class_credits, work_credits: work_credits, total: total)
      end

      def parse_professors
        professors_table = @doc.xpath(settings_at_key(:professors_table))
        professors_table.map do |row|
          prof_data = element_text_at_xpath(row, 'td[2]/font').split(' - ')
          Professor.find_or_create_by(code: prof_data.first.to_i, name: prof_data.last)
        end
      end

      def parse_evaluation
        evaluation_table = @doc.xpath(settings_at_key(:evaluation_table))
        method = element_text_at_xpath(evaluation_table.first, 'td/font')
        criterion = element_text_at_xpath(evaluation_table[1], 'td/font')
        rec = element_text_at_xpath(evaluation_table.last, 'td/font')
        CourseEvaluation.create(method: method, criterion: criterion, rec: rec)
      end
    end
  end
end
