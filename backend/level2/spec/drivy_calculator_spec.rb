require "json"
require_relative "../drivy_calculator"

describe DrivyCalculator do
  let(:data) { File.read("./level2/data.json") }
  let(:output) { JSON.parse(File.read("./level2/output.json")).to_json } # doing this to avoid matching on spacing

  after do
    Rental.delete_all
    Car.delete_all
  end

  subject { DrivyCalculator.new(data) }

  describe "to_json" do
    it "return transformed data in JSON format" do
      expect(subject.to_json).to eq(output)
    end
  end
end
