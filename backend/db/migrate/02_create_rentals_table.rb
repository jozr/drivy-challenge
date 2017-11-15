class CreateRentalsTable < ActiveRecord::Migration[4.2]
  def change
    create_table :rentals do |t|
      t.references :car, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :distance
    end
  end
end
