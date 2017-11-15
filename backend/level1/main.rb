require "json"
require "date"
require "pry"
require "active_record"
require_relative "../environment.rb"

class Main
  def transform(data)
    store_data!(data)
    { "rentals" => rental_output }
  end

  private

  def rental_output
    Rental.all.map { |rental| { "id" => rental.id, "price" => rental.price  } }
  end

  def store_data!(data)
    data["cars"].each { |car_data| Car.create(car_data) }
    data["rentals"].each { |rental_data| Rental.create(rental_data) }
  end
end

class Rental < ActiveRecord::Base
  belongs_to :car

  def price
    (distance * car.price_per_km) + (days * car.price_per_day)
  end

  private

  def days
    @days ||= (end_date - start_date).to_i + 1
  end
end

class Car < ActiveRecord::Base
  has_one :rental
end
