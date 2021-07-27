# == Schema Information
#
# Table name: employees
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  nickname               :string
#  occupation             :integer          default("waiter")
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_employees_on_confirmation_token    (confirmation_token) UNIQUE
#  index_employees_on_email                 (email) UNIQUE
#  index_employees_on_reset_password_token  (reset_password_token) UNIQUE
#  index_employees_on_uid_and_provider      (uid,provider) UNIQUE
#
FactoryBot.define do
  factory :employee do
    name { Faker::Name.name }
    nickname { Faker::FunnyName.name }
    email { Faker::Internet.email }
    password { "123456" }
    password_confirmation { "123456" }
    occupation { :admin }
  end
end
