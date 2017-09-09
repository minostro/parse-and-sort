require 'actions'

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
      expect(person.date_of_birth).to eq("04/08/1983")
    end
  end
end
