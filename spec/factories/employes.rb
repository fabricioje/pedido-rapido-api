# == Schema Information
#
# Table name: employes
#
#  id                     :bigint           not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  name                   :string
#  nickname               :string
#  email                  :string
#  occupation             :integer          default("waiter")
#  tokens                 :json
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
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
