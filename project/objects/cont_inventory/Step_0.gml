/// @description step -- cont_inventory
// code here >
/// CHECKING FOR INVENTORY WITHIN MOUSE POSITION
	focusing_inventory = null;
	with (obj_inventory_base) {
		if (other.focusing_inventory == null) 
		&& (mouse_gui_x > x and mouse_gui_x < x+200) {
			other.focusing_inventory = self;
		}
	}
	
/// FINDING THE RIGHT INDEX
	if (focusing_inventory != null) {
		// get focusing_inventory grid positions
	}