/// @description create -- obj_inventory_base

// !!! INTERACTIONS NOT INCLUDED !!!
// ACTIONS ARE HANDLED IN obj_inventory
// or any other inherited inventories

// code here >
// PRIVATE
__ = {};
// VARIABLES INITIALIZATION
// __ init __
__.init = function(_self) {
	// defaults
	_self[$ "array_size"	] ??= 18;
	_self[$ "orientation"	] ??= horizontal;
	_self[$ "grid_size"		] ??= 32; // width and height of each grid
	_self[$ "grid_gap"		] ??= 4;  // gap between each grid
	_self[$ "grids_per_row" ] ??= 4;  // amount of grids per row
	// for mouse check
	// width and height of entire inventory calculated
	_self[$ "width" ] ??= 0; 
	_self[$ "height"] ??= 0;
	update_width_and_height();
	// //
	// forced defaults
	array = array_create(array_size);
	reset_array();
	// [{pos:{x,y}, item, amount, favourite}, ...] //
	// //							 // //
}
// functions for management
	add_item = function(_item, _amount = 1) {
		var _remainding_amount = _amount;
		var _array_length = array_size;
		#region // find matching slot {
			for(var _i = 0; _i < _array_length; _i++) {
				var _index = ptr(array[_i]); // array index pointer
				// check matching id and stack not full
				if (_index.item.id == _item.id and _index.amount != _index.item.stack_size) {
					// check stack size
						// remainding space > amount adding
					var _remainding_space = _index.item.stack_size -_index.amount;
					if(_remainding_space > _amount) { 
						_index.amount += _amount
						return; // stack fits, finish adding
					} else {
						_index.amount += _remainding_space;
						_remainding_amount -= _remainding_space;
					}
				}
			} // end for loop
		#endregion }
		#region // find empty slot {
			for(var _i = 0; _i < _array_length; _i++) {
				var _index = ptr(array[_i]); // array index pointer
				// check for empty space
				if (_index.item.id == ITEM.nothing.id) {
					if (_item.stack_size > _remainding_amount) {
						_index.item = _item;
						_index.amount = _remainding_amount;
						return; // stack fits, finish adding
					} else {
						_index.item = _item;
						_index.amount = _item.stack_size;
						_remainding_amount -= _item.stack_size; // doesnt fit, just add_item and reduce amount
					}
				}
			} // end for loop
		#endregion }
		// else is inventory is full
		// // drop_the_rest(); WIP !!! !!! !!! !!!
		show_debug_message($"ref: '{self}' inventory is full while trying to add_item");
	}
	remove_item = function(_item, _index, _amount = 1) {
		var _inventory = array[_index];
		show_debug_message($"Calling inventory's remove_item(index: {_index}, amount: {_amount})");
		// Make sure it's possible
		if (_amount > _inventory.amount) {
			// not possible, return false (can be used for amount check)
			show_debug_message("Failed to call remove_item(): insufficient amount in inventory");
			return false;
		}
	
	    if (_inventory.item.id != ITEM.nothing.id) {
	        _inventory.amount -= _amount;
	    }
		// Set item to nothing when it reach zero
		if (_inventory.amount == 0) {
			_inventory.item = ITEM.nothing;	
		}
		// Removed successfully
		return true;
	}
	find_and_remove_item = function(_item, _amount = 1) {
		var _array_length = array_length(array);
		for(var _i = 0; _i < _array_length; _i++) {
			// Find same item,
			// Remove it (if it's too much, remember, deduct total, and find in other index)
		}
	}
	reset_array = function() {
		array_foreach(array, function(_e, _i) {
			array[_i] = { item : ITEM.nothing, amount : -1, favourite : false };
		});	
	}
	clear_item = function() {
		array_foreach(array, function(_e, _i) {
			_e.item = ITEM.nothing;
			_e.amount = -1;
		});
	}
	clear_favourite = function() {
		array_foreach(array, function(_e, _i) {
			_e.favourite = false;
		});	
	}
	// UPDATE
	update_width_and_height = function() {
		// update width
		var _size_per_grid = grid_size + grid_gap;
			// = front gap + (row size * (grid + gap))
		width  = grid_gap + (min(grids_per_row, array_size) * _size_per_grid);
			// = top gap + (rounded up of array size / row size) *
		height = grid_gap + (ceil(array_size / grids_per_row) * _size_per_grid);
	}
	
	// SETTERS
	set_array_size = function(_size) {
		array_size = _size;
		array_resize(array, array_size);
		// //
		return self;	
	}
	set_orientation = function(_orientation) {
		orientation = _orientation;
		// //
		return self;	
	}
		
// end create
	__.init(self);