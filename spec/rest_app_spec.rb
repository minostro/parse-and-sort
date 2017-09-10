require "rack/test"
require_relative '../rest_app'

RSpec.describe RestApp, "#main" do
  include Rack::Test::Methods

  def app
    app = RestApp
    builder = Rack::Builder.new
    builder.run app
  end

  before(:each) do
    #HINT: doing this because I'm keeping state in the server
    get("/clean")
  end

  context "Records" do
    it "posts a record" do
      json = {
        "data": "Inostroza|Milton|Male|Blue|04/08/1983",
        "delimiter": "|"
      }.to_json

      post("/records", json, { 'CONTENT_TYPE' => 'application/json' })
      expect(last_response.body).to eq({records: 1}.to_json)
    end

    context "get when server has no records" do
      it "gets record by name" do
        get("/records/name")
        response = JSON.parse(last_response.body)

        expect(response.size).to eq(0)
        expect(response).to eq([])
      end

      it "gets record by gender" do
        get("/records/gender")
        response = JSON.parse(last_response.body)

        expect(response.size).to eq(0)
        expect(response).to eq([])
      end

      it "gets record by birthdate" do
        get("/records/gender")
        response = JSON.parse(last_response.body)

        expect(response.size).to eq(0)
        expect(response).to eq([])
      end
    end

    context "get when server has at least one record" do
      let(:expected_response) {[{
          "last_name"=>"Inostroza",
          "first_name"=>"Milton",
          "gender"=>"Male",
          "favorite_color"=>"Blue",
          "date_of_birth"=>"8/4/1983"
      }]}

      before do
        json = {
          "data": "Inostroza|Milton|Male|Blue|04/08/1983",
          "delimiter": "|"
        }.to_json
        post("/records", json, { 'CONTENT_TYPE' => 'application/json' })
      end

      it "gets record by name" do
        get("/records/name")
        response = JSON.parse(last_response.body)

        expect(response.size).to eq(1)
        expect(response).to eq(expected_response)
      end

      it "gets record by gender" do
        get("/records/gender")
        response = JSON.parse(last_response.body)

        expect(response.size).to eq(1)
        expect(response).to eq(expected_response)
      end

      it "gets record by birthdate" do
        get("/records/gender")
        response = JSON.parse(last_response.body)

        expect(response.size).to eq(1)
        expect(response).to eq(expected_response)
      end
    end
  end
end
