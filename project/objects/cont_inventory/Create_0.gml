/// @description create -- cont_inventory
// code here >
// Singleton
if (instance_number(cont_inventory) > 1) {
	instance_destroy();
	show_error("duplicated singleton - cont_inventory", true);
}
// Variable to use across the inventories
	// Hovered inventory
	focusing_inventory = null;
	focusing_inventory_index = null;
	// Opened inventory
	// Primary / Main (such as player's)
	main_inventory = null;
	// Secondary / Sub (such as chest's)
	sub_inventroy = null;
#region DEBUG OVERLAY
	dbg_watch(ref_create(self, "focusing_inventory"))
	dbg_watch(ref_create(self, "focusing_inventory_index"))
#endregion
// Create mouse inventory object
	mouse = instance_create_layer(x,y,layer,obj_inventory_mouse);