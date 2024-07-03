/// @description desc
// code here >
// Variable to use across the inventories
	inventories_list = ds_list_create();

// Create mouse inventory object
	instance_create_layer(x,y,layer,obj_inventory_mouse);

// Function to create other inventories
	create_inventory = function() {
		ds_list_add(inventories_list, inventory_create());	
	}