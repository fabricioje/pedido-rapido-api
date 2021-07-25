require 'rails_helper'

RSpec.describe Employe, type: :model do
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:nickname) }

  it { is_expected.to validate_presence_of(:occupation) }
  it { is_expected.to define_enum_for(:occupation).with_values({ admin: 0, waiter: 1 }) }

  it { is_expected.to validate_presence_of(:email) }

  it { is_expected.to have_many(:orders) }
end
