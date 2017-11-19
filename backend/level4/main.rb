require "active_record"
require_relative "./models/car"
require_relative "./models/rental"
require_relative "../environment.rb"

class Main
  def transform(data)
    store_data!(data)
    { "rentals" => rental_output }
  end

  private

  def rental_output
    Rental.all.map { |rental| rental.to_hash }
  end

  def store_data!(data)
    data["cars"].each { |car_data| Car.create(car_data) }
    data["rentals"].each { |rental_data| Rental.create(rental_data) }
  end
end
