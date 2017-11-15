class CreateCarsTable < ActiveRecord::Migration[4.2]
  def change
    create_table :cars do |t|
      t.integer :price_per_day
      t.integer :price_per_km
    end
  end
end
