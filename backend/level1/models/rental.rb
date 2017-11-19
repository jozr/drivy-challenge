require "active_record"

class Rental < ActiveRecord::Base
  belongs_to :car

  def price
    price_for_distance + price_for_time
  end

  private

  def price_for_distance
    @price_for_distance ||= distance * car.price_per_km
  end

  def price_for_time
    @price_for_time ||= days * car.price_per_day
  end

  def days
    @days ||= (end_date - start_date).to_i + 1
  end
end
