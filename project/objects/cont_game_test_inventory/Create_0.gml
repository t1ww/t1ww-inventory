/// @description (testing cont_game)
// code here >
#region DEBUG OVERLAY
	dbg_view("Value", true, 100);
	dbg_button("add apple",function(){
		main_inventory.add_item(ITEM.apple, 15360);	
	});
#endregion

// Create the inventory controller
instance_create_layer(x,y,layer, cont_inventory);

// Create inventory + ui
main_inventory = instance_create_layer(x,y, layer, obj_inventory);
main_inventory.set_array_size(29).set_grid_gap(10);

cont_inventory.main_inventory = main_inventory;