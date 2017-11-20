require "active_record"
require_relative "../lib/rental_price_calculator"

class Rental < ActiveRecord::Base
  belongs_to :car
  has_many :actions
  has_many :rental_modifications
  after_save :store_actions!

  def to_hash
    { 
      "id" => id,
      "actions" => actions.map { |action| action.to_hash },
    } 
  end

  def days
    @days ||= (end_date - start_date).to_i + 1
  end

  private

  def store_actions!
    ["driver", "owner", "insurance", "assistance", "drivy"].each do |who|
      amount = send(:"#{who}_amount").to_i
      Action.create(rental_id: id, who: who, amount: amount)
    end
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
