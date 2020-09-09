FactoryBot.define do
  factory :car, class: 'Car' do
    carModel { Faker::Lorem.word }
    manufacturer { Faker::Company.name }
    owner { Faker::Lorem.word }
  end
end
