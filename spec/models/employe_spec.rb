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
require 'rails_helper'

RSpec.describe Employe, type: :model do
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:nickname) }

  it { is_expected.to validate_presence_of(:occupation) }
  it { is_expected.to define_enum_for(:occupation).with_values({ admin: 0, waiter: 1, cooker: 2 }) }

  it { is_expected.to validate_presence_of(:email) }

  it { is_expected.to have_many(:orders) }
end
