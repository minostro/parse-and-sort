require 'date'

class Person
  attr_accessor :last_name, :first_name, :gender, :favorite_color, :date_of_birth
  def initialize(attrs)
    self.last_name,
    self.first_name,
    self.gender,
    self.favorite_color,
    self.date_of_birth = attrs
  end

  def self.build(attrs)
    #TODO: Add checks for
    #1.- number of attributes
    #2.- gender: either female or male
    date_of_birth = attrs[4]
    attrs[4] = Date.parse(date_of_birth)
    Person.new(attrs)
  end
end
