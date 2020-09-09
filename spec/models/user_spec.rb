require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:cars) }
  # Validation tests
  # ensure name, email and password_digest are present before save
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_inclusion_of(:admin).in_array([true, false]) }
end
