FactoryBot.define do
  factory :user do
    username { Faker::Name.first_name }
    email {'foo@bar.com'}
    password {'foobar'}
    role { 'Admin' }
  end
end