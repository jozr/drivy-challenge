require "json"
require "date"

class Director
  def json
    { rentals: rentals }.to_json
  end

  private

  def rentals
    rental_hashes.map do |rental_hash|
      rental = Rental.new(
        rental_hash["id"], 
        rental_hash["car_id"], 
        rental_hash["start_date"], 
        rental_hash["end_date"], 
        rental_hash["distance"]
      )
      { id: rental.id, price: rental.price }
    end
  end

  def rental_hashes
    @rental_hashes ||= JSON.parse(File.read("./level1/data.json"))["rentals"]
  end
end

class Rental
  attr_reader :id, :car_id, :start_date, :end_date, :distance

  def initialize(id, car_id, start_date, end_date, distance)
    @id         = id
    @car_id     = car_id
    @start_date = start_date
    @end_date   = end_date
    @distance   = distance
  end

  def price
    (distance * car.price_per_km) + (days * car.price_per_day)
  end

  private

  def car
    @car ||= Car.new(car_hash["id"], car_hash["price_per_day"], car_hash["price_per_km"])
  end

  def car_hash
    @car_hash ||= cars.find { |car| car["id"] == car_id }
  end

  def cars
    @cars ||= JSON.parse(File.read("./level1/data.json"))["cars"]
  end

  def days
    @days ||= (parsed_date(end_date) - parsed_date(start_date)).to_i + 1
  end

  def parsed_date(date_string)
    Date.parse(date_string)
  end
end

class Car
  attr_reader :id, :price_per_day, :price_per_km

  def initialize(id, price_per_day, price_per_km)
    @id            = id
    @price_per_day = price_per_day
    @price_per_km  = price_per_km
  end
end
