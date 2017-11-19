require "active_record"
require_relative "../lib/rental_price_calculator"

class Rental < ActiveRecord::Base
  belongs_to :car

  def to_hash
    { 
      "id" => id,
      "actions" => actions,
    } 
  end

  def days
    @days ||= (end_date - start_date).to_i + 1
  end

  private

  def actions
    ["driver", "owner", "insurance", "assistance", "drivy"].map do |who|
      action_for(who)
    end
  end

  def action_for(who)
    amount = self.send(:"#{who}_amount").to_i

    {
      "who"    => who,
      "type"   => amount < 0 ? "debit" : "credit",
      "amount" => amount.abs
    }
  end

  def driver_amount
    @driver_amount ||= -(price + deductible_reduction_price)
  end

  def owner_amount
    @owner_amount ||= price - commission_total
  end

  def drivy_amount
    @drivy_amount ||= 
      (commission_total + deductible_reduction_price) - (assistance_amount + insurance_amount)
  end

  def assistance_amount
    @assistance_amount ||= days * 100
  end

  def insurance_amount
    @insurance_amount ||= commission_total * 0.5
  end

  def commission_total
    @commission_total ||= price * 0.3
  end

  def deductible_reduction_price
    @deductible_reduction_price ||= begin
      return 0 unless deductible_reduction
      
      400 * days
    end
  end

  def price
    @price ||= RentalPriceCalculator.new(self, car).calculated_price
  end
end
