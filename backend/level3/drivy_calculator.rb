require "json"
require "active_record"
require_relative "./models/car"
require_relative "./models/rental"
require_relative "../environment.rb"

class DrivyCalculator
  def initialize(json)
    @json = json
    store_data!
  end

  def to_json
    { "rentals" => rental_hashes }.to_json
  end

  private

  attr_reader :json

  def rental_hashes
    Rental.all.map do |rental| 
      { 
        "id"         => rental.id, 
        "price"      => rental.price, 
        "commission" => rental.commission_info,
      }
    end
  end

  def store_data!
    parsed_data["cars"].each { |car_data| Car.create(car_data) }
    parsed_data["rentals"].each { |rental_data| Rental.create(rental_data) }
  end

  def parsed_data
    @parsed_data ||= JSON.parse(json)
  end
end
