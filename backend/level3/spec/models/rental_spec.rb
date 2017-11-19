require_relative "../../models/car"
require_relative "../../models/rental"
require_relative "../../../environment.rb"

describe Rental do
  after do
    Rental.delete_all
    Car.delete_all
  end

  let(:car) { Car.create }
  let(:rental) { Rental.create(car: car) }

  describe "price" do
    let(:price_for_distance) { 3 }
    let(:price_for_time) { 2 }

    before do
      allow(rental).to receive(:price_for_distance).and_return(price_for_distance)
      allow(rental).to receive(:price_for_time).and_return(price_for_time)
    end

    it "returns the sum of the price for distance and time" do
      expect(rental.price).to eq(price_for_distance + price_for_time)
    end
  end

  describe "commission_info" do
    let(:insurance_fee) { 1 }
    let(:assistance_fee) { 2 }
    let(:drivy_fee) { 3 }

    before do
      allow(rental).to receive(:insurance_fee).and_return(insurance_fee)
      allow(rental).to receive(:assistance_fee).and_return(assistance_fee)
      allow(rental).to receive(:drivy_fee).and_return(drivy_fee)
    end

    it "returns a has of commission information" do
      expect(rental.commission_info).to eq(
        "insurance_fee"  => insurance_fee,
        "assistance_fee" => assistance_fee,
        "drivy_fee"      => drivy_fee,
      )
    end
  end
end
