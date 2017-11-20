require "active_record"

class Action < ActiveRecord::Base
  belongs_to :rental

  def to_hash
    {
      "who"    => who,
      "type"   => amount < 0 ? "debit" : "credit",
      "amount" => amount.abs,
    }
  end
end
