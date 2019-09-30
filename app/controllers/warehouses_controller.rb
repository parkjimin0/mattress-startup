class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :update, :destroy]

  # GET /warehouses
  def index
    @warehouses = Warehouse.all

    render json: @warehouses
  end

  # GET /warehouses/1
  def show
    @warehouse = Warehouse.includes(:inventories).where(id: params[:id], "inventories.damaged" => false)

    render json: @warehouse[0], :include => :inventories
  end

  # POST /warehouses
  def create
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save
      render json: @warehouse, status: :created, location: @warehouse
    else
      render json: @warehouse.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /warehouses/1
  def update
    if @warehouse.update(warehouse_params)
      render json: @warehouse
    else
      render json: @warehouse.errors, status: :unprocessable_entity
    end
  end

  # DELETE /warehouses/1
  def destroy
    @warehouse.destroy
  end

  private

    def set_warehouse
      @warehouse = Warehouse.find(params[:id])
    rescue
      render :json => { :errors => 'Warehouse not found' }
    end

    def warehouse_params
      params.require(:warehouse).permit(:name, :location)
    end
end
