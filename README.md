# README
Welcome to the REST Assured, a JSON API service to CRUD inventories in warehouses for mattresses.

# Getting Started

## Development setup
1. Seed the database to fill up your hive center: `rake db:seed` 
2. Start to run the app: `rails server` and head to the hive center homepage/port :`localhost:3000`
3. To test the APIs for creating and updating
    response body format should be:
        - For Warehouse
            `{
	            "warehouse": {
		            "name": "Jimin's New Warehouse",
		            "location": "Somewhere in the World"
	            }
            }`
        - For Inventory
           ` {
	            "inventory": {
		            "name": "Fixed Mattress",
		            "default": true, 
	            }
            } `

## Testing
- Run Specs via `bundle exec rspec`
