class InventoriesController < ApplicationController
  before_action :set_warehouse
  before_action :set_inventory, only: [:show, :update, :destroy]

  # GET /warehouses/:warehouse_id/inventories to show ALL inventories (damaged and not)
  def index
    @inventories = @warehouse.inventories

    render json: @inventories
  end

  # GET /warehouses/:warehouse_id/inventories/:id
  def show
    render json: @inventory
  end

  # POST /warehouses/:warehouse_id/inventories
  def create
    @inventory = @warehouse.inventories.create(inventory_params)

    if @inventory.save
      render json: @inventory, status: :created
    else
      render json: @inventory.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /warehouses/:warehouse_id/inventories/:id
  def update
    if @inventory.update(inventory_params)
      render json: @inventory
    else
      render json: @inventory.errors, status: :unprocessable_entity
    end
  end

  # DELETE /warehouses/:warehouse_id/inventories/:id
  def destroy
    @inventory.destroy
  end

  private

    def set_warehouse
      @warehouse = Warehouse.find(params[:warehouse_id])
    rescue
      render :json => { :errors => 'Warehouse not found' }
    end

    def set_inventory
      @inventory = Inventory.find(params[:id])
    rescue
      render :json => { :errors => 'Inventory not found' }
    end

    def inventory_params
      params.require(:inventory).permit!
    end
end
