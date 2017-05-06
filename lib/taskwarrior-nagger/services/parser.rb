module TaskwarriorNagger::Parser
  autoload :Json, 'taskwarrior-nagger/services/parser/json'
  autoload :Csv,  'taskwarrior-nagger/services/parser/csv'

  def self.parse(results)
    TaskwarriorNagger::Config.version > '1.9.2' ? Json.parse(results) : Csv.parse(results)
  end
end
