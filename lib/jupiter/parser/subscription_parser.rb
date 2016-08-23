module Jupiter
  module Parser
    class SubscriptionParser < Base
      attr_reader :subscriptions

      def initialize(doc)
        @doc = doc
        super()
      end

      private

      def parse
        create_subscriptions
      end

      def create_subscriptions
        @subscriptions = []
        subscription_data = @doc.xpath('tr')[1..-1]
        subscription_data.each do |row|
          subscription = create_subscription(row)
          subscription.type = @subscriptions.last.type if subscription.type.nil?
          subscriptions << subscription
        end
      end

      def create_subscription(row)
        subscription = Subscription.new
        fields = row.xpath('td')
        first_field = fields[0].at_xpath('font/span')
        if first_field.nil?
          subscription.assigned_to = element_text_at_xpath(fields[1], 'font/span')
          fields = fields[2..-1]
        else
          subscription.type = first_field.text.strip
          fields = fields[1..-1]
        end
        [:vacancy, :subscribed, :pending, :enrolled].each do |subscription_field|
          subscription.send("#{subscription_field}=", element_text_at_xpath(fields.shift, 'font/span').to_i)
        end
        subscription
      end
    end
  end
end
