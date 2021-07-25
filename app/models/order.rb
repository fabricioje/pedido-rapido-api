class Order < ApplicationRecord
  belongs_to :employe

  validates :table_numer, presence: true
end
