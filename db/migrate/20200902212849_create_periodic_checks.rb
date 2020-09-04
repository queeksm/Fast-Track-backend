class CreatePeriodicChecks < ActiveRecord::Migration[5.2]
  def change
    create_table :periodic_checks do |t|
      t.float :mileage
      t.float :gasPerformance
      t.string :passed
      t.date :maintenance
      t.references :car, foreign_key: true

      t.timestamps
    end
  end
end
