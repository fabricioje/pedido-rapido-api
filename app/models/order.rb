# == Schema Information
#
# Table name: orders
#
#  id          :bigint           not null, primary key
#  delete_at   :datetime
#  name        :string
#  status      :string
#  table_numer :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  employee_id :bigint           not null
#
# Indexes
#
#  index_orders_on_employee_id  (employee_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_id => employees.id)
#
class Order < ApplicationRecord
  belongs_to :employee
  has_many :order_items, dependent: :destroy

  validates :table_numer, presence: true
end
