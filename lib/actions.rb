require 'parser'
module Actions
  def self.build_people_from_file(filepath, delimiter)
    File.foreach(filepath).map do |line|
      build_person_from_string(line.chomp, delimiter)
    end
  end

  def self.build_person_from_string(data, delimiter)
    Parser.parse(data, delimiter)
  end
end
