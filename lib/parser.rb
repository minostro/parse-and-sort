require 'person'

module Parser
  def self.parse(string_data, delimiter)
    attrs = string_data.split(delimiter)
    Person.build(attrs)
  end
end
