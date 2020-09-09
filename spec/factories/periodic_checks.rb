FactoryBot.define do
  factory :periodic_check do
    mileage { Faker::Number.between(250, 52_000) }
    gasPerformance { Faker::Number.between(12.5, 35.6) }
    passed { 'true' }
    maintenance { Faker::Date.backward(35) }
  end
end
