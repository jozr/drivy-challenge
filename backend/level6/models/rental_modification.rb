require_relative "../lib/action_hash_helper"

class RentalModification < ActiveRecord::Base
  include ActionHashHelper

  belongs_to :rental
  before_save :update_rental!

  def to_hash
    {
      "id" => id,
      "rental_id" => rental.id,
      "actions" => modified_action_hashes,
    }
  end

  private

  def modified_action_hashes
    parties.map { |who| hash_for(who, amount_for(who)) }
  end

  def amount_for(who)
    actions = Action.where(who: who, rental: rental)
    actions.last.amount - actions.first.amount
  end

  def update_rental!
    rental_attributes = attributes.select { |k, v| v && k != "rental_id" && k != "id" }
    rental.update(rental_attributes)
  end

  def parties
    @parties ||= Action.all.map(&:who).uniq
  end
end
