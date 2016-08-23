class ParserSettings < Settingslogic
  source Rails.root.join('config', 'parser.yml')

  namespace Rails.env
end
