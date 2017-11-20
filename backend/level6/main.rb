require "active_record"
require_relative "./models/car"
require_relative "./models/rental"
require_relative "./models/action"
require_relative "./models/rental_modification"
require_relative "../environment.rb"

class Main
  def transform(data)
    store_data!(data)
    modifications = data["rental_modifications"]

    if modifications
      store_modifications!(modifications)
      { "rental_modifications" => rental_modifications }
    else
      { "rentals" => rentals }
    end    
  end

  private

  def rental_modifications
    RentalModification.all.map { |rental_mod| rental_mod.to_hash } 
  end

  def rentals
    Rental.all.map { |rental| rental.to_hash } 
  end

  def store_data!(data)
    data["cars"].each { |car_data| Car.create(car_data) }
    data["rentals"].each { |rental_data| Rental.create(rental_data) }
  end

  def store_modifications!(modifications)
    modifications.each { |rental_mod_data| RentalModification.create(rental_mod_data) }
  end
end
