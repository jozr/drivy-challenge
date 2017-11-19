class RentalPriceCalculator
  def initialize(rental, car)
    @rental = rental
    @car    = car
  end

  def calculated_price
    price_for_distance + price_for_time
  end

  private

  attr_reader :car, :rental

  def price_for_distance
    @price_for_distance ||= rental.distance * car.price_per_km
  end

  def price_for_time
    @price_for_time ||= [*1..rental.days].reduce(0) do |sum, num_of_day| 
      sum + price_per_day(num_of_day).to_i
    end
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
end
