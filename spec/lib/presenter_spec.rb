require 'presenter'
require 'person'

RSpec.describe Presenter, "#people_to_string" do
  let(:female_data) {
    ["Inostroza", "Milton2", "Female", "Black", "04/08/1985"]
  }
  let(:male_data) {
    ["Inostroza", "Milton", "Male", "Blue", "04/08/1983"]
  }
  let(:female_person) { Person.build(female_data) }
  let(:male_person) { Person.build(male_data) }

  context "with one person" do
    let(:people) { [female_person] }
    let(:delimiter) { "|" }
    it "returns an array that contains one pipe-delimited string" do
      result = Presenter.people_to_string(people, delimiter)
      female_data[4] = "8/4/1985"
      expect(result).to eq([female_data.join(delimiter)].join("\n"))
    end
  end

  context "with more than one person" do
    let(:people) { [male_person, female_person]}
    let(:delimiter) { "|" }
    it "returns an array that contains pipe-delimited strings" do
      result = Presenter.people_to_string(people, delimiter)
      male_data[4] = "8/4/1983"
      female_data[4] = "8/4/1985"
      expect(result).to eq([
        male_data.join(delimiter),
        female_data.join(delimiter)
      ].join("\n"))
    end
  end
end

RSpec.describe Presenter, "#people_to_json" do
  let(:female_person) { 
    Person.build(["Inostroza", "Milton2", "Female", "Black", "04/08/1985"])
  }
  let(:male_person) {
    Person.build(["Inostroza", "Milton", "Male", "Blue", "04/08/1983"])
  }

  context "with one person" do
    let(:people) { [female_person] }
    it "returns a json array with one person" do
      result = Presenter.people_to_json(people)
      expected_result = [{
        last_name: "Inostroza",
        first_name: "Milton2",
        gender: "Female",
        favorite_color: "Black",
        date_of_birth: "8/4/1985"
      }]
      expect(result).to eq(expected_result.to_json)
    end
  end

  context "with more than one person" do
    let(:people) { [male_person, female_person]}
    it "returns a json array with two people" do
      result = Presenter.people_to_json(people)
      female_expected_result = {
        last_name: "Inostroza",
        first_name: "Milton2",
        gender: "Female",
        favorite_color: "Black",
        date_of_birth: "8/4/1985"
      }
      male_expected_result = {
        last_name: "Inostroza",
        first_name: "Milton",
        gender: "Male",
        favorite_color: "Blue",
        date_of_birth: "8/4/1983"
      }
      expect(result).to eq([
        male_expected_result,
        female_expected_result
      ].to_json)
    end
  end
end
