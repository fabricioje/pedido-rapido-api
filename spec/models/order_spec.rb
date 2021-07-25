require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to validate_presence_of(:table_numer) }

  it { is_expected.to belong_to :employe }
end
