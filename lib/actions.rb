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
    female = people.select{|person| person.gender == "Female" }
    male = people.select{|person| person.gender == "Male" }
    (female + male).sort do |left, right|
      left.last_name <=> right.last_name
    end
  end

  def self.sort_by_birth_date(people)
    people.sort{|left, right| left.date_of_birth <=> right.date_of_birth}
  end

  def self.sort_by_last_name(people)
    people.sort{|left, right| right.last_name <=> left.last_name}
  end

  def self.people_to_string(people, delimiter)
    people.map do |person|
      person_to_string(person, delimiter)
    end.join("\n")
  end

  private
  def self.person_to_string(person, delimiter)
    date_of_birth = person.date_of_birth
    [ person.last_name,
      person.first_name,
      person.gender,
      person.favorite_color,
      date_of_birth.strftime("%-m/%-d/%Y")
    ].join(delimiter)
  end
end
