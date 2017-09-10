require 'json'

module Presenter
  def self.people_to_string(people, delimiter)
    people.map do |person|
      person_to_string(person, delimiter)
    end.join("\n")
  end

  def self.people_to_json(people)
    people.map do |person|
      person_to_hash(person)
    end.to_json
  end

  private
  def self.person_to_string(person, delimiter)
    [ person.last_name,
      person.first_name,
      person.gender,
      person.favorite_color,
      person.date_of_birth.strftime("%-m/%-d/%Y")
    ].join(delimiter)
  end

  def self.person_to_hash(person)
    {
      last_name: person.last_name,
      first_name: person.first_name,
      gender: person.gender,
      favorite_color: person.favorite_color,
      date_of_birth: person.date_of_birth.strftime("%-m/%-d/%Y")
    }
  end
end
