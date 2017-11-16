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
    price_for_distance + price_for_time
  end

  private

  def price_for_distance
    distance * car.price_per_km
  end

  def price_for_time
    [*1..days].reduce(0) { |sum, num_of_day| sum + price_per_day(num_of_day).to_i }
  end

  def price_per_day(num_of_day)
    if num_of_day > 10
      base_price_per_day * 0.5
    elsif num_of_day > 4
      base_price_per_day * 0.7
    elsif num_of_day > 1
      base_price_per_day * 0.9
    else
      base_price_per_day
    end
  end

  def base_price_per_day
    @base_price_per_day ||= car.price_per_day
  end

  def days
    @days ||= (end_date - start_date).to_i + 1
  end
end

class Car < ActiveRecord::Base
  has_one :rental
end
