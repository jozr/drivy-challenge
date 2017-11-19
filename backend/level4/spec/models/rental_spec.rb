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

  describe "to_hash" do
    let(:price) { 1_000 }
    let(:option_info) { { "foo" => "bar" } }
    let(:commission_info) { { "bar" => "foo" }  }

    before do
      allow(rental).to receive(:price).and_return(price)
      allow(rental).to receive(:option_info).and_return(option_info)
      allow(rental).to receive(:commission_info).and_return(commission_info)
    end

    it "returns rental information in a hash" do
      expect(rental.to_hash).to eq(
        "id"         => rental.id,
        "price"      => price,
        "options"    => option_info,
        "commission" => commission_info,
      )
    end
  end
end
