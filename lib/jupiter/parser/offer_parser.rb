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
        @doc = doc
        @code = code
        parse
      end

      def self.setting_key
        :offers
      end

      private

      def parse
        create_static_fields
        create_offers
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
        schedules = Jupiter::Parser::ScheduleParser.new(schedule_element).schedule
        subsciptions = Jupiter::Parser::SubscriptionParser.new(subscription_element).subscriptions
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
