class AddDeductibleReductionToRentals < ActiveRecord::Migration[4.2]
  def change
    add_column :rentals, :deductible_reduction, :boolean
  end
end
