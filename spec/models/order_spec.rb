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
require "rails_helper"

RSpec.describe Order, type: :model do
  it { is_expected.to validate_presence_of(:table_number) }

  it { is_expected.to belong_to :employee }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to define_enum_for(:status).with_values({ pending: 0, completed: 1, canceled: 2 }) }
end
