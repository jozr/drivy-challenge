require_relative "../../models/car"
require_relative "../../models/rental"
require_relative "../../../environment.rb"

describe RentalPriceCalculator do
  after do
    Rental.delete_all
    Car.delete_all
  end

  let(:car) { instance_double(Car) }
  let(:rental) { instance_double(Rental) }
  let(:calculator) { RentalPriceCalculator.new(rental, car) }

  describe "calculated_price" do
    let(:price_for_distance) { 30 }
    let(:price_for_time) { 20 }

    before do
      allow(calculator).to receive(:price_for_distance).and_return(price_for_distance)
      allow(calculator).to receive(:price_for_time).and_return(price_for_time)
    end

    it "returns the sum of the price per distance and time" do
      expect(calculator.calculated_price).to eq(price_for_distance + price_for_time)
    end
  end
end
