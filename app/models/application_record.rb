class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Exclude internal id info from json output
  def as_json(options = {})
    options[:except] ||= [:id]
    super(options)
  end
end
