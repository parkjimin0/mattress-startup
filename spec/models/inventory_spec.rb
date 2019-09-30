require 'rails_helper'

describe Inventory do
	context 'associations' do
		it "ensure Inventory model has a one to many relationship with Warehouse model" do
			should belong_to(:warehouse) 
		end
	end

	context 'validations' do
		it "is valid if name is present" do
			should validate_presence_of(:name) 
		end
	end
end
