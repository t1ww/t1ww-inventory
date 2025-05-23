// macros / constants
// const
#macro horizontal 0
#macro vertical 1
#macro null pointer_null
#macro mouse_gui_x device_mouse_x_to_gui(0)
#macro mouse_gui_y device_mouse_y_to_gui(0)

/// functions
// SAVING AND LOADING SCRIPTS
function inventory_save(_filename, _inventory){
	var _struct = {}
	with(_inventory){
		_struct.x = x;
		_struct.y = y;
		_struct.sizes = sizes;
		_struct.wraps = wraps;
		_struct.orientation = orientation;
		_struct.type_limitation = type_limitation;
		// ds_grid saving
		_struct.grid = grid_to_struct(grid);
	}
	var _string = json_stringify(_struct);
	var _file = file_text_open_write(_filename);
	file_text_write_string(_file,_string);
	file_text_close(_file);
	show_debug_message($"Saved inventory to {_filename} successfully");
}
function inventory_load(_filename){
	if(file_exists(_filename)){
		var _file = file_text_open_read(_filename);	
		var _json = file_text_read_string(_file);
		var _struct = json_parse(_json);
		var _inventory = inventory_create(_struct.x,_struct.y,_struct.sizes,_struct.wraps,_struct.orientation);
		
		// load items in inventory
		var _grid = struct_to_grid(_struct.grid);
		_inventory.set_grid(_grid);
		
		file_text_close(_file);		
		show_debug_message($"Loaded {_filename} inventory successfully");
		return _inventory;
	}
	show_debug_message($"{_filename} not found");
}