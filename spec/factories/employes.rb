FactoryBot.define do
  factory :employe do
    name { Faker::Name.name }
    nickname { Faker::FunnyName.name }
    email { Faker::Internet.email }
    password { "123456" }
    password_confirmation { "123456" }
    occupation { :admin }
  end
end
