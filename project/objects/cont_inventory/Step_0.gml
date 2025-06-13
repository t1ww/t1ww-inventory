/// @description step -- cont_inventory
// code here >
/// CHECKING FOR NEAREST CHEST


/// CHECKING FOR INVENTORY WITHIN MOUSE POSITION, ONLY IF ACTIVE
	focusing_inventory = null;
	focusing_inventory_index = null;
	with (obj_inventory_base) {
		/// FINDING THE RIGHT INVENTORY
		if (cont_inventory.focusing_inventory == null) 
		&& (mouse_gui_x > x and mouse_gui_x < x + width) 
		&& (mouse_gui_y > y and mouse_gui_y < y + height)
		&& (self.active == true){
			cont_inventory.focusing_inventory = self;
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
/*
	 // If inventory focused
	 // and one of it's index is focused
	 // and mouse or inventory has something
*/
if ((focusing_inventory != null)
and (focusing_inventory_index != null)
and (focusing_inventory.array[focusing_inventory_index].item.id != ITEM.nothing.id or mouse.inventory.item.id != ITEM.nothing.id)
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
		_action = focusing_inventory.action.none; // safety
	} 
	// Mouse actions
		_action.left();
		_action.right();
} else {
	// Only if Mouse in not in any inventory area
	if (focusing_inventory == null ) {
		// Use item in mouse
		if (mouse_check_button_pressed(mb_left)) {
			mouse.use_item();
		}
		// Drop 1 item
		if (mouse_check_button_pressed(mb_right) and ! keyboard_check(vk_control)){
			mouse.remove_item();
		}
		// Drop all item
		if (mouse_check_button_pressed(mb_right) and keyboard_check(vk_control)){
			mouse.clear_item();
		}
	}
}