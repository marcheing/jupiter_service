class Subscription
  TYPES = [
    'Obrigatória'.freeze,
    'Optativa Eletiva'.freeze,
    'Optativa Livre'.freeze
  ].freeze

  attr_accessor :type, :assigned_to, :vacancy, :subscribed, :pending, :enrolled
end
