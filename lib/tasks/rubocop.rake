if Rails.env.test? || Rails.env.development?
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new

  task default: 'rubocop'
end
