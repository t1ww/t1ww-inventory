/// @description step -- cont_inventory
// code here >
/// CHECKING FOR INVENTORY WITHIN MOUSE POSITION
	focusing_inventory = null;
	focusing_inventory_index = null;
	with (obj_inventory_base) {
		/// FINDING THE RIGHT INVENTORY
		if (other.focusing_inventory == null) 
		&& (mouse_gui_x > x and mouse_gui_x < x + width) 
		&& (mouse_gui_y > y and mouse_gui_y < y + height){
			other.focusing_inventory = self;
			break; // using "break" because "return" will exit the code
		}
	}

/// FINDING THE RIGHT INDEX
if (focusing_inventory != null) { 
	with (focusing_inventory) {
		for(var i = 0; i < array_size; i++){
			var _start_x = 0, _start_y = 0, _end_x = 0, _end_y = 0;
			_start_x = grid_gap + x + ((i mod grids_per_row) * (grid_size + grid_gap));
			_start_y = grid_gap + y + ((i div grids_per_row) * (grid_size + grid_gap));
			_end_x = _start_x + grid_size;
			_end_y = _start_y + grid_size;
			// check condition
			if (mouse_gui_x > _start_x and mouse_gui_x < _end_x)
			&& (mouse_gui_y > _start_y and mouse_gui_y < _end_y) {
				other.focusing_inventory_index = i;
				break;
			}
		}
	}
}
// //

/// ACTIONS
if (
	focusing_inventory != null 
and focusing_inventory_index != null
// (item both not empty at the same time)
and !(focusing_inventory.array[focusing_inventory_index].item.id == ITEM.nothing.id and mouse.inventory.item.id == ITEM.nothing.id)
) {
	var _action = null;
	// held down keys
	if (keyboard_check(vk_alt)) {
		// HELD ALT
		_action = focusing_inventory.action.alt;
	} else 
	if (keyboard_check(vk_shift)) {
		// HELD SHIFT
		_action = focusing_inventory.action.shift;
	} else
	if (keyboard_check(vk_control)) {
		// HELD CONTROL
		_action = focusing_inventory.action.control;
	} else {
		// HELD NONE
		_action = focusing_inventory.action.none; // just in case
	} 
	// clicks
	if (mouse_check_button_pressed(mb_left)) {
		_action.left();
	} else
	if (mouse_check_button_pressed(mb_right)){
		_action.right();	
	}
} else {
	if (mouse_check_button_pressed(mb_left)) {
		// drop whole item
		mouse.clear_item();
	}
	if (mouse_check_button_pressed(mb_right)){
		mouse.remove();
	}
}