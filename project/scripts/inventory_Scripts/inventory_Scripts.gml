// macros / constants
// const
#macro horizontal 0
#macro vertical 1
/// functions
// save and load
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
// creation
function inventory_create(_x = 0,_y = 0,_sizes = 1,_wraps = -1,_orientation = horizontal
							,_typeLimitationArray = null, _active = false){
	var inv = instance_create_depth(_x,_y,0,obj_inventory);
	inv.set_size(_sizes)
		.set_wraps(_wraps)
		.set_orientation(_orientation)
		.set_type_limitation(_typeLimitationArray)
		;
	if(_active){inv.active = true;}
	return inv;
}
function hotbar_create(_x = 0,_y = 0,_sizes = 1,_wraps = -1,_orientation = horizontal
							,_typeLimitationArray = null, _active = false){
	var inv = instance_create_depth(_x,_y,0,obj_hotbar_inventory);
	inv.set_size(_sizes)
		.set_wraps(_wraps)
		.set_orientation(_orientation)
		.set_type_limitation(_typeLimitationArray)
		;
	if(_active){inv.active = true;}
	return inv;
}
function market_inventory_create(_x = 0,_y = 0,_sizes = 1,_wraps = -1,_orientation = horizontal, _active = false){
	var inv = instance_create_depth(_x,_y,0,obj_market_inventory);
	inv.set_size(_sizes)
		.set_wraps(_wraps)
		.set_orientation(_orientation)
		;
	if(_active){inv.active = true;}
	return inv;
}
// management
function inventory_add(_inventory, _item, _amount = 1){
	with(_inventory){
		add_item(_item,_amount);	
	}
}
function inventory_remove(_inventory, _item, _amount = 1){
	with(_inventory){
		// wip	
	}
}