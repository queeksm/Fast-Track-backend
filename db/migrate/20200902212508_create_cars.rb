class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :owner
      t.string :carModel
      t.string :manufacturer

      t.timestamps
    end
  end
end
