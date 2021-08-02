# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#  delete_at    :datetime
#  name         :string
#  status       :integer          default("pending")
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
FactoryBot.define do
  factory :order do
    name { Faker::Name.name }
    table_number { Faker::Number.between(from: 1, to: 10) }
    employee

    trait :with_items do
      after :create do |order|
        order_items = create_list(:order_item, 5, order: order)
        # order.subtotal = items.sum(:payed_price)
        # order.total_amount = order.subtotal
      end
    end
  end
end
