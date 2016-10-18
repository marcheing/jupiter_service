module Jupiter
  module Parser
    class OfferParser < Base
      PAGE_FIELDS = [
        :faculty_name,
        :cycle_name,
        :course
      ].freeze

      attr_accessor :code
      attr_reader :offers, *PAGE_FIELDS

      def initialize(doc, code)
        @code = code
        super(doc)
      end

      def self.setting_key
        :offers
      end

      def response_hash
        successful? ? success_hash : failure_hash
      end

      private

      def failure_hash
        { errors: @errors }
      end

      def success_hash
        {
          faculty_name: @faculty_name,
          cycle_name: @cycle_name,
          course: @course,
          offers: @offers
        }
      end

      def parse
        check_if_there_is_an_offer
        create_static_fields
        create_offers
        success
      rescue ParserError => error
        failure(error.message)
      end

      def check_if_there_is_an_offer
        warning = parse_field(:web_message)
        return if warning.empty?
        if /#{settings[:there_is_no_offer]}/ =~ warning
          raise ParserError, 'No offer associated with this course'
        else
          raise ParserError, "The page gave a warning: #{warning}"
        end
      end

      def offer_number
        @doc.xpath(settings[self.class.setting_key][:separator]).size
      end

      def create_static_fields
        PAGE_FIELDS.each do |field|
          instance_variable_set(:"@#{field}", parse_field(field))
        end
      end

      def create_offer(elements)
        offer_element = elements.find { |element| element.text =~ /Código/ }
        schedule_element = find_xml_element_that_starts_with 'Horário', elements
        didactic_activity_element = find_xml_element_that_starts_with 'Atividades', elements
        subscription_element = elements.find { |element| element.text =~ /Matriculados/ }
        Offer.new.tap do |offer|
          Offer::FIELDS.each do |field|
            offer.instance_variable_set(:"@#{field}", parse_field(field, offer_element))
          end
          parse_offer_elements(offer, schedule_element, didactic_activity_element, subscription_element)
        end
      end

      def parse_offer_elements(offer, schedule_element, didactic_activity_element, subscription_element)
        offer.schedules = Jupiter::Parser::ScheduleParser.new(schedule_element).schedules unless schedule_element.nil?
        offer.didactic_activities = Jupiter::Parser::DidacticActivityParser.new(didactic_activity_element).didactic_activities unless didactic_activity_element.nil?
        offer.subscriptions = Jupiter::Parser::SubscriptionParser.new(subscription_element).subscriptions
      end

      def create_offers
        @offers = []
        offer_elements = @doc.xpath(settings[self.class.setting_key][:separator])
        offer_elements.each do |offer_element|
          tables = recursively_get_relevant_offer_tables([], offer_element)
          @offers << create_offer(tables)
        end
      end

      def recursively_get_relevant_offer_tables(current_tables, offer_element)
        element = offer_element.previous_element
        # Going through the elements, the method will stop if there isn't anything else (nil) or reaches the previous offer (hr)
        return current_tables if element.nil? || element.name == 'hr'
        current_tables << element if element.name == 'table'
        recursively_get_relevant_offer_tables(current_tables, element)
      end
    end
  end
end
