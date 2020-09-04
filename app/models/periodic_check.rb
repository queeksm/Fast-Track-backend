class PeriodicCheck < ApplicationRecord
  belongs_to :car

  validates_presence_of :mileage, :gasPerformance, :passed, :maintenance
end
