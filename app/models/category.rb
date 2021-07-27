# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
    has_many :products, dependent: :restrict_with_error

    validates :name, presence: true, uniqueness: { case_sensitive: false }
end
