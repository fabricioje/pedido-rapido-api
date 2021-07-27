# == Schema Information
#
# Table name: order_items
#
#  id         :bigint           not null, primary key
#  comment    :text
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_order_items_on_order_id    (order_id)
#  index_order_items_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_id => products.id)
#
require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  subject { build(:order_item) } 

  it { is_expected.to validate_presence_of(:quantity) }
  it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }

  it { is_expected.to validate_presence_of(:product_id) }
  it { is_expected.to validate_presence_of(:order_id) }

  it { is_expected.to belong_to :product }
  it { is_expected.to belong_to :order }
end
