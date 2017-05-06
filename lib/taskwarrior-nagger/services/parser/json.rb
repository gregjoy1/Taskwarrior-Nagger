require 'json'

module TaskwarriorNagger::Parser::Json
  def self.parse(json)
    json.strip!
    json == '[No matches.]' ? [] : ::JSON.parse(json)
  end
end
