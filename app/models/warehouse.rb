class Warehouse < ApplicationRecord
    has_many :inventories, :dependent => :destroy

    validates :name, :presence => true
    validates :location, :presence => true
end
