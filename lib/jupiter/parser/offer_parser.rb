module Jupiter
  module Parser
    class OfferParser < Base
      PAGE_FIELDS = [
        :faculty_name,
        :cycle_name,
        :course
      ].freeze

      NUMBER_OF_TABLES_PER_OFFER = 3

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
        @doc.xpath(settings[self.class.setting_key][:separator]).size / NUMBER_OF_TABLES_PER_OFFER
      end

      def create_static_fields
        PAGE_FIELDS.each do |field|
          instance_variable_set(:"@#{field}", parse_field(field))
        end
      end

      def create_offer(elements)
        offer_element = elements.first
        schedule_element = elements.second
        subscription_element = elements.third
        offer = Offer.new
        Offer::FIELDS.each do |field|
          offer.instance_variable_set(:"@#{field}", parse_field(field, offer_element))
        end
        offer.schedules = Jupiter::Parser::ScheduleParser.new(schedule_element).schedules
        offer.subscriptions = Jupiter::Parser::SubscriptionParser.new(subscription_element).subscriptions
        offer
      end

      def create_offers
        @offers = []
        offer_elements = @doc.xpath(settings[self.class.setting_key][:separator])
        offer_elements.each_slice(NUMBER_OF_TABLES_PER_OFFER) do |tables|
          @offers << create_offer(tables)
        end
      end
    end
  end
end
