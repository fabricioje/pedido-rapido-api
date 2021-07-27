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
require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to validate_presence_of(:table_numer) }

  it { is_expected.to belong_to :employe }
end
