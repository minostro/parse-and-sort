require 'actions'
require 'person'

RSpec.describe Actions, "#build_people_from_string" do
  let(:last_name) { "Inostroza" }
  let(:first_name) { "Milton" }
  let(:gender) { "Male" }
  let(:favorite_color) { "Blue" }
  let(:date_of_birth) { "04/08/1983" }
  let(:delimited_data) do
    [ last_name,
      first_name,
      gender,
      favorite_color,
      date_of_birth].join(delimiter)
  end

  context "with comma-delimited data" do
    let(:delimiter) { "," }
    it "builds a person with the given data" do
      person = Actions.build_person_from_string(delimited_data, delimiter)
      expect(person.last_name).to eq("Inostroza")
      expect(person.first_name).to eq("Milton")
      expect(person.gender).to eq("Male")
      expect(person.favorite_color).to eq("Blue")
      expect(person.date_of_birth).to eq(Date.parse("04/08/1983"))
    end
  end
end

RSpec.describe Actions, "#build_people_from_file" do
  def create_test_file!(filepath, delimiter)
    first = ["Inostroza", "Milton", "Male", "Blue", "04/08/1983"]
    second = ["Inostroza2", "Milton2", "Female", "Black", "04/08/1985"]
    result = [first, second].map do |person|
      person.join(delimiter)
    end.join("\n")
    File.write(filepath, result)
  end

  context "with comma-delimited data" do
    let(:delimiter) { "," }
    let(:filepath) { "/tmp/test-data" }

    it "returns an array of people" do
      create_test_file!(filepath, delimiter)
      people = Actions.build_people_from_file(filepath, delimiter)

      first, second = people
      expect(people.size).to eq(2)

      expect(first.last_name).to eq("Inostroza")
      expect(first.first_name).to eq("Milton")
      expect(first.gender).to eq("Male")
      expect(first.favorite_color).to eq("Blue")
      expect(first.date_of_birth).to eq(Date.parse("04/08/1983"))

      expect(second.last_name).to eq("Inostroza2")
      expect(second.first_name).to eq("Milton2")
      expect(second.gender).to eq("Female")
      expect(second.favorite_color).to eq("Black")
      expect(second.date_of_birth).to eq(Date.parse("04/08/1985"))
    end
  end
end

RSpec.describe Actions, "#sort_by_last_name" do
  let(:first_person) {
    Person.build(["Inostroza", "Milton", "Male", "Blue", "04/08/1983"])
  }
  let(:second_person) {
    Person.build(["Inostroza2", "Milton2", "Female", "Black", "04/08/1985"])
  }

  context "with one person" do
    let(:people) { [first_person] }
    it "returns a sorted array" do
      expect(Actions.sort_by_last_name(people)).to eq(people)
    end
  end

  context "with more than one person" do
    let(:people) { [first_person, second_person]}
    it "returns a sorted array" do
      expected_people = [second_person, first_person]
      expect(Actions.sort_by_last_name(people)).to eq(expected_people)
    end
  end
end

RSpec.describe Actions, "#sort_by_birth_date" do
  let(:first_person) {
    Person.build(["Inostroza", "Milton", "Male", "Blue", "04/08/1983"])
  }
  let(:second_person) {
    Person.build(["Inostroza2", "Milton2", "Female", "Black", "04/08/1985"])
  }

  context "with one person" do
    let(:people) { [first_person] }
    it "returns a sorted array" do
      expect(Actions.sort_by_birth_date(people)).to eq(people)
    end
  end

  context "with more than one person" do
    let(:people) { [second_person, first_person]}
    it "returns a sorted array" do
      expected_people = [first_person, second_person]
      expect(Actions.sort_by_birth_date(people)).to eq(expected_people)
    end
  end
end

RSpec.describe Actions, "#sort_by_gender" do
  let(:female_person) {
    Person.build(["Inostroza", "Milton2", "Female", "Black", "04/08/1985"])
  }
  let(:male_person) {
    Person.build(["Inostroza", "Milton", "Male", "Blue", "04/08/1983"])
  }

  context "with one person" do
    let(:people) { [female_person] }
    it "returns a sorted array" do
      expect(Actions.sort_by_gender(people)).to eq(people)
    end
  end

  context "with more than one person" do
    let(:people) { [male_person, female_person]}
    it "returns a sorted array" do
      expected_people = [female_person, male_person]
      expect(Actions.sort_by_gender(people)).to eq(expected_people)
    end
  end
end
