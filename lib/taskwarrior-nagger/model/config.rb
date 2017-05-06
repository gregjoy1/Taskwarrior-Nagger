require 'parseconfig'
require 'versionomy'

module TaskwarriorNagger::Config
  # A list of date formats, with Taskwarrior's on the left and the Ruby
  # equivalent on the right.
  RUBY_DATEFORMATS = {
    'm' => '%-m',  # minimal-digit month, for example 1 or 12
    'd' => '%-d',  # minimal-digit day, for example 1 or 30
    'y' => '%y',   # two-digit year, for example 09
    'D' => '%d',   # two-digit day, for example 01 or 30
    'M' => '%m',   # two-digit month, for example 01 or 12
    'Y' => '%Y',   # four-digit year, for example 2009
    'a' => '%a',   # short name of weekday, for example Mon or Wed
    'A' => '%A',   # long name of weekday, for example Monday or Wednesday
    'b' => '%b',   # short name of month, for example Jan or Aug
    'B' => '%B',   # long name of month, for example January or August
    'V' => '%U',   # weeknumber, for example 03 or 37
    'H' => '%H',   # two-digit hour, for example 03 or 11
    'N' => '%M',   # two-digit minutes, for example 05 or 42
    'S' => '%S',   # two-digit seconds, for example 07 or 47
  }

  def self.version
    @version ||= Versionomy.parse(`#{TaskwarriorNagger::Runner::TASK_BIN} _version`.strip)
  end

  def self.store
    @store ||= self.parse_config
  end

  def self.property(prop)
    self.store[prop]
  end

  def self.dateformat(format = :ruby)
    return nil unless self.store['dateformat'] && format.in?([:ruby])

    self.store['dateformat'].gsub(/(\w)/, RUBY_DATEFORMATS)
  end

  def self.supports?(feature)
    case feature.to_sym
      when :editing then self.version.major > 1
      when :_show then self.version >= '2.2.0'
      else false
    end
  end

  def self.method_missing(method)
    self.store[method.to_s]
  end

  private

  def self.parse_config
    if self.supports? :_show
      config = `#{TaskwarriorNagger::Runner::TASK_BIN} _show`
      config.split("\n").inject({}) do |h, line|
        key,value = line.split('=')
        h.merge!({ key => value })
      end
    else
      ParseConfig.new("#{Dir.home}/.taskrc")
    end
  end
end
