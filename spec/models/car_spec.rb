require 'rails_helper'

RSpec.describe Car, type: :model do
  it { should have_many(:periodic_checks).dependent(:destroy) }
  it { should validate_presence_of(:carModel) }
  it { should validate_presence_of(:owner) }
  it { should validate_presence_of(:manufacturer) }
end
