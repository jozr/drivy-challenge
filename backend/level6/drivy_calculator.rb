require "json"
require "active_record"
require_relative "./models/car"
require_relative "./models/rental"
require_relative "./models/action"
require_relative "./models/rental_modification"
require_relative "../environment.rb"

class DrivyCalculator
  def initialize(json)
    @json = json
    store_data!
  end

  def to_json
    if rental_modifications_data
      { "rental_modifications" => rental_modification_hashes }.to_json
    else
      { "rentals" => rental_hashes }.to_json
    end
  end

  private

  attr_reader :json

  def rental_hashes
    Rental.all.map { |rental| rental.to_hash }
  end

  def store_data!
    parsed_data["cars"].each { |car_data| Car.create(car_data) }
    parsed_data["rentals"].each { |rental_data| Rental.create(rental_data) }

    store_modifications! if rental_modifications_data
  end

  def rental_modification_hashes
    RentalModification.all.map { |rental_modification| rental_modification.to_hash } 
  end

  def store_modifications!
    rental_modifications_data.each do |rental_modification_data|
      RentalModification.create(rental_modification_data)
    end
  end

  def rental_modifications_data
    @rental_modifications_data ||= parsed_data["rental_modifications"]
  end

  def parsed_data
    @parsed_data ||= JSON.parse(json)
  end
end
