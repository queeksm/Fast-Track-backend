class Car < ApplicationRecord
  has_many :periodic_checks, dependent: :destroy
  
  validates_presence_of :owner, :carModel, :manufacturer
end
