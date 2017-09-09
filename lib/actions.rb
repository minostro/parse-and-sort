require 'parser'
module Actions
  def self.build_person_from_string(data, delimiter)
    Parser.parse(data, delimiter)
  end
end
