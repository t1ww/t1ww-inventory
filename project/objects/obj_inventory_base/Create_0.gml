/// @description create -- obj_inventory_base
// code here >
// VARIABLES INITIALIZATION
// __ init __
__INIT = function() {
	// defaults
	self[$ "array_size" ] ??= 18;
	self[$ "orientation"] ??= horizontal;
	self[$ "grid_size"  ] ??= 32;
	self[$ "grid_gap"   ] ??= 4;
	self[$ "grid_line_limit"] ??= 4;
	// //
	// forced defaults
	array = array_create(array_size);
	reset_array();
	array_focus_index = -1;
	// [{pos:{x,y}, item, amount, favourite}, ...] //
	// //							 // //
}
// functions for management
	add = function(_item, _amount = 1) {
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
						_remainding_amount -= _item.stack_size; // doesnt fit, just add and reduce amount
					}
				}
			} // end for loop
		#endregion }
		// else is inventory is full
		//
		// // drop_the_rest(); WIP !!! !!! !!! !!!
		//
		show_debug_message($"ref: '{self}' inventory is full while trying to add");
	}
	remove = function(_item, _amount = 1) {
		var _array_length = array_length(array);
		#region // find matching slot {
			for(var _i = 0; _i < _array_length; _i++) {
				var _index = ptr(array[_i]); // array index pointer
				if (_index.item.id != ITEM.nothing.id) {
					_index.amount -= _amount;
					if (_index._amount == 0) {
						_index.item = ITEM.nothing;
						_index._amount = -1;
					}
				}
			} // end for loop
		#endregion }
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
	__INIT();