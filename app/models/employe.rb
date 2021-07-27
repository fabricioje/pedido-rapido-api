# frozen_string_literal: true

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
class Employe < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :orders, dependent: :destroy

  validates :name, presence: true
  validates :nickname, presence: true
  validates :email, presence: true
  validates :occupation, presence: true

  enum occupation: { admin: 0, waiter: 1, cooker: 2 }
end
