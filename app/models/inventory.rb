class Inventory < ApplicationRecord
  belongs_to :warehouse

  validates :name, :presence => true
end
