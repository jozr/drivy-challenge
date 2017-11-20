module ActionHashHelper
  def hash_for(who, amount)
    {
      "who"    => who,
      "type"   => amount < 0 ? "debit" : "credit",
      "amount" => amount.abs,
    }
  end
end
