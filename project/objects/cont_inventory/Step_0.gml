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
			var _start_x, _start_y, _end_x, _end_y;
			_start_x = grid_gap + x + ((i mod grids_per_row) * (grid_size + grid_gap));
			_end_x = _start_x + grid_size;
			_start_y = grid_gap + y + ((i div grids_per_row) * (grid_size + grid_gap));
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
