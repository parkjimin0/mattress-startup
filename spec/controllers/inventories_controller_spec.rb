require 'rails_helper'

describe InventoriesController do

  let(:valid_attributes) {
    {
      name: "New Warehouse"
    }
  }

  let(:invalid_attributes) {
    {
      name: ""
    }
  }

  before do 
    create(:warehouse)
    @warehouse = Warehouse.first
    @damaged_inventory = create(:inventory, damaged: true)
    @undamaged_inventory = create(:inventory)
    @warehouse.inventories << @damaged_inventory
    @warehouse.inventories << @undamaged_inventory
  end

  describe "#index" do
    it "returns status code 200" do
      get :index, params: { warehouse_id: @warehouse.id }
      expect(response).to have_http_status(200)
    end

    it "returns all damaged and undamaged inventories of a warehouse" do
      get :index, params: { warehouse_id: @warehouse.id }
      body = JSON.parse(response.body)
      expect(body.count).to eq(2)
    end
  end

  describe "#show" do
    it "returns an inventory" do
      get :show, params: {warehouse_id: @warehouse.id, id: @damaged_inventory.id}
      body = JSON.parse(response.body)
      expect(body["name"]).to eq("Test Inventory")
    end
  end

  describe "#create" do
    context "with valid params" do
      it "creates a new Inventory" do
        expect {
          post :create, params: {warehouse_id: @warehouse.id, inventory: valid_attributes}
        }.to change(Inventory, :count).by(1)
      end

      it "renders a JSON response with the new inventory" do
        post :create, params: {warehouse_id: @warehouse.id, inventory: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new inventory" do
        post :create, params: {warehouse_id: @warehouse.id, inventory: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "#update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: "Updated Inventory"
        }
      }

      it "updates the requested inventory" do
        put :update, params: {warehouse_id: @warehouse.id, id: @undamaged_inventory.id, inventory: new_attributes}
        body = JSON.parse(response.body)
        expect(body["name"]). to eq("Updated Inventory")
      end

      it "renders a JSON response with the inventory" do
        put :update, params: {warehouse_id: @warehouse.id, id: @undamaged_inventory.id, inventory: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the inventory" do
        put :update, params: {warehouse_id: @warehouse.id, id: @undamaged_inventory.id, inventory: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested inventory" do
      inventory = @warehouse.inventories.create({name: "To be deleted inventory"})
      delete :destroy, params: {warehouse_id: @warehouse.id, id: inventory.to_param}
      expect(Inventory.find_by({name: "To be deleted inventory"})).to be_nil
    end
  end
end
