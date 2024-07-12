/// @description (testing cont_game)
// code here >
#region DEBUG OVERLAY
	dbg_view("Value", true, 100);
#endregion

// Create the inventory controller
instance_create_layer(x,y,layer, cont_inventory);

// Create inventory + ui
instance_create_layer(x,y, layer, obj_inventory_base);