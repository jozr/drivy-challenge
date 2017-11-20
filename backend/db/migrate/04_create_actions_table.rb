class CreateActionsTable < ActiveRecord::Migration[4.2]
  def change
    create_table :actions do |t|
      t.references :rental, index: true, foreign_key: true
      t.string :who
      t.integer :amount
    end
  end
end
