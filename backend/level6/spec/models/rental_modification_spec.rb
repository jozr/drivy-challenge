require_relative "../../models/action"
require_relative "../../models/rental_modification"
require_relative "../../../environment.rb"

describe RentalModification do
  after do
    RentalModification.delete_all
    Action.delete_all
    Rental.delete_all
    Car.delete_all
  end

  let(:car) { Car.create(price_per_km: 4, price_per_day: 10) }
  let(:start_date) { "2015-03-31" }
  let(:end_date) { "2015-04-04" }
  let(:rental) { Rental.create(car: car, start_date: start_date, end_date: end_date, distance: 500) }
  let(:rental_modification) { RentalModification.create(rental: rental) }

  describe "to_hash" do
    let(:modified_action_hashes) { [{}] }

    before do
      allow(rental_modification).to receive(:modified_action_hashes).and_return(modified_action_hashes)
    end

    it "returns rental information in a hash" do
      expect(rental_modification.to_hash).to eq(
        "id"        => rental_modification.id,
        "rental_id" => rental.id,
        "actions"   => modified_action_hashes,
      )
    end
  end
end
