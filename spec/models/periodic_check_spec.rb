require 'rails_helper'

RSpec.describe PeriodicCheck, type: :model do
  it { should belong_to(:car) }  
  it { should validate_presence_of(:mileage) }
  it { should validate_presence_of(:gasPerformance) }
  it { should validate_presence_of(:passed) }
  it { should validate_presence_of(:maintenance) }
end
