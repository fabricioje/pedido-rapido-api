# == Schema Information
#
# Table name: order_items
#
#  id         :bigint           not null, primary key
#  order_id   :bigint           not null
#  product_id :bigint           not null
#  quantity   :integer
#  comment    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
