class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Exclude internal attributes info from json output
  def as_json(options = {})
    options[:except] ||= []
    options[:except] |= [:id, :created_at, :updated_at]
    super(options)
  end
end
