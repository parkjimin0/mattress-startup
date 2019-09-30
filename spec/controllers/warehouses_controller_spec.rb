require 'rails_helper'

describe WarehousesController do
  let(:valid_attributes) {
    {
      name: "New Warehouse",
      location: "New location"
    }
  }

  let(:invalid_attributes) {
    {
      name: ""
    }
  }

  before(:all) do 
		@warehouses = create_list(:warehouse, 10)
	end

  describe "#index" do
    it 'returns status code 200' do
      get :index
      all_warehouses = Warehouse.all
      expect(all_warehouses.count).to eq(10)
    end

    it 'returns status code 200' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "#show" do
    before do 
      @warehouse = Warehouse.last
      @damaged_inventory = create(:inventory, damaged: true)
      @undamaged_inventory = create(:inventory)
      @warehouse.inventories << @damaged_inventory
      @warehouse.inventories << @undamaged_inventory
    end

    it "returns a warehouse with undamaged inventory" do
      get :show, params: {id: @warehouse.id}
      body = JSON.parse(response.body)
      expect(body["inventories"].count).to eq(1)
    end

    it "returns a success response" do
      get :show, params: {id: @warehouse.id}
      expect(response).to have_http_status(200)
    end

    it "renders a JSON response" do
      get :show, params: {id: @warehouse.id}
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Warehouse" do
        expect {
          post :create, params: { warehouse: valid_attributes }
        }.to change(Warehouse, :count).by(1)
      end

      it "renders a JSON response with the new warehouse" do
        post :create, params: { warehouse: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.location).to eq(warehouse_url(Warehouse.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new warehouse" do
        post :create, params: {warehouse: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "#update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: "Updated Warehouse"
        }
      }

      it "updates the requested warehouse" do
        warehouse = Warehouse.create! valid_attributes
        put :update, params: {id: warehouse.id, warehouse: new_attributes}
        body = JSON.parse(response.body)
        expect(body["name"]).to eq("Updated Warehouse")
      end

      it "renders a JSON response with the warehouse" do
        warehouse = Warehouse.create! valid_attributes

        put :update, params: {id: warehouse.id, warehouse: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the warehouse" do
        warehouse = Warehouse.create! valid_attributes

        put :update, params: {id: warehouse.id, warehouse: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "#destroy" do
    it "destroys the requested warehouse" do
      warehouse = Warehouse.create! valid_attributes
      expect {
        delete :destroy, params: {id: warehouse.id}
      }.to change(Warehouse, :count).by(-1)
    end
  end
end
