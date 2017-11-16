require "active_record"

class Car < ActiveRecord::Base
  has_one :rental
end
