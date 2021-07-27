# == Schema Information
#
# Table name: orders
#
#  id          :bigint           not null, primary key
#  name        :string
#  table_numer :string
#  employe_id  :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :string
#  delete_at   :datetime
#
class Order < ApplicationRecord
  belongs_to :employe
  has_many :order_items, dependent: :destroy

  validates :table_numer, presence: true
end
