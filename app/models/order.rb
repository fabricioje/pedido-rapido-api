# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#  delete_at    :datetime
#  name         :string
#  status       :integer          default(0)
#  table_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  employee_id  :bigint           not null
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
  include Paginatable
  include LikeSearchable

  belongs_to :employee

  has_many :order_items, dependent: :destroy

  validates :table_number, presence: true
  validates :status, presence: true
  validates :name, presence: true

  enum status: { pending: 0, completed: 1, canceled: 2 }
end
