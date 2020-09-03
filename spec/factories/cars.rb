FactoryBot.define do
  factory :car do
    owner { Faker::Name.name }
    carModel { Faker::Lorem.word }
    manufacturer { Faker::Company.name}
  end
end