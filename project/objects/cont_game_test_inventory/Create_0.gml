/// @description (testing cont_game)
// code here >
#region DEBUG OVERLAY
	dbg_view("Value", true, 100);
	dbg_button("add apple",function(){
		inv.add(ITEM.apple, 15623);	
	});
#endregion

// Create the inventory controller
instance_create_layer(x,y,layer, cont_inventory);

// Create inventory + ui
inv = instance_create_layer(x,y, layer, obj_inventory,
{
	grid_gap : 12,
	array_size : 29,
});
