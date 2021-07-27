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
require "rails_helper"

RSpec.describe Order, type: :model do
  it { is_expected.to validate_presence_of(:table_numer) }

  it { is_expected.to belong_to :employee }
end
