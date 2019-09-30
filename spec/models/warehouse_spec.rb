require 'rails_helper'

describe Warehouse do
	context 'associations' do
		it "ensure Warehouse model has a one to many relationship with Inventory model" do
			should have_many(:inventories).dependent(:destroy) 
		end
	end

	context 'validations' do
		it "is valid if name is present" do
			should validate_presence_of(:name) 
    end
    
    it "is valid if location is present" do
			should validate_presence_of(:location) 
		end
	end
end
