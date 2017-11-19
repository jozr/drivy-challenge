require "date"
require_relative "../../models/car"
require_relative "../../models/rental"
require_relative "../../../environment.rb"

describe Rental do
  after do
    Rental.delete_all
    Car.delete_all
  end

  let(:car) { Car.create }
  let(:start_date) { "2015-03-31" }
  let(:end_date) { "2015-04-04" }
  let(:rental) { Rental.create(car: car, start_date: start_date, end_date: end_date) }

  describe "to_hash" do
    let(:actions) { ["data"] }

    before do
      allow(rental).to receive(:actions).and_return(actions)
    end

    it "returns rental information in a hash" do
      expect(rental.to_hash).to eq(
        "id"      => rental.id,
        "actions" => actions,
      )
    end
  end

  describe "days" do
    it "returns the days in between the start and end date" do
      expect(
        (Date.parse(end_date) - Date.parse(start_date)).to_i + 1
      ).to eq(rental.days)
    end
  end
end
