# frozen_string_literal: true

class Employe < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true
  validates :nickname, presence: true
  validates :email, presence: true
  validates :occupation, presence: true

  enum occupation: { admin: 0, waiter: 1 }
end
