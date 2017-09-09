require_relative 'parser'

module Actions
  def self.build_people_from_file(filepath, delimiter)
    File.foreach(filepath).map do |line|
      build_person_from_string(line.chomp, delimiter)
    end
  end

  def self.build_person_from_string(data, delimiter)
    Parser.parse(data, delimiter)
  end

  def self.sort_by_gender(people)
  end

  def self.sort_by_birth_date(people)
  end

  def self.sort_by_last_name(people)
    people.sort{|left, right| right.last_name <=> left.last_name}
  end

  def self.people_to_string(people, delimiter)
  end

  def self.person_to_string(person, delimiter)
  end
end
