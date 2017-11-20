class CreateRentalModificationsTable < ActiveRecord::Migration[4.2]
  def change
    create_table :rental_modifications do |t|
      t.references :car, index: true, foreign_key: true
      t.references :rental, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :distance
      t.boolean :deductible_reduction
    end
  end
end
