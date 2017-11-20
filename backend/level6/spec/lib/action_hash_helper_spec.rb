require_relative "../../lib/action_hash_helper"

describe ActionHashHelper do
  let(:action_hash_helper) { ( Class.new { include ActionHashHelper } ).new }

  describe "hash_for()" do
    let(:who) { "you" }
    let(:amount) { 100 }

    it "returns action information in hash format" do
      expect(action_hash_helper.hash_for(who, amount)).to eq(
        "who"    => who,
        "type"   => amount < 0 ? "debit" : "credit",
        "amount" => amount.abs,
      )
    end
  end
end