require_relative "../lib/action_hash_helper"

class Action < ActiveRecord::Base
  include ActionHashHelper
  belongs_to :rental

  def to_hash
    hash_for(who, amount)
  end
end
