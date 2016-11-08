class DidacticActivity < ApplicationRecord
  belongs_to :professor
  belongs_to :offer

  def as_json(options = {})
    options[:except] ||= []
    options[:except] |= [:professor_id]
    options[:methods] ||= []
    options[:methods] |= [:professor]
    super(options)
  end
end
