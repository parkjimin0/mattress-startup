# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
Warehouse.destroy_all
Inventory.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!("warehouses")
ActiveRecord::Base.connection.reset_pk_sequence!("inventories")

warehouse_list = [
    "Jimin's Warehouse",
    "Tim's Warehouse",
    "David's Warehouse", 
    "Julio's Warehouse",
    "Anthony's Warehouse", 
]

warehouse_list.each do |name|
    Warehouse.create( name: name, location: "USA" )
end


Warehouse.all.each do |warehouse| 
    warehouse.inventories.create(:name => "Pretty Mattress" )
    warehouse.inventories.create(:name => "Ugly Mattress", damaged: true )
    warehouse.inventories.create(:name => "Nice Mattress" )
    warehouse.inventories.create(:name => "Smelly Mattress", damaged: true )
    warehouse.inventories.create(:name => "New Mattress" )
    warehouse.inventories.create(:name => "Old Mattress", damaged: true )
end