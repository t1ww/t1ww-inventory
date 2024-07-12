/// @description create -- obj_inventory_base
// code here >
// VARIABLES INITIALIZATION
	// defaults
	self[$ "array_size" ] ??= 18;
	self[$ "orientation"] ??= horizontal;
	self[$ "grid_size"  ] ??= 32;
	self[$ "grid_gap"   ] ??= 4;
	self[$ "grid_line_limit"] ??= 4;
	// //
	// forced defaults
	array = array_create(array_size, { item : ITEM.nothing, amount : -1, favourite : false });
	array_focus_index = -1;
	// [{pos:{x,y}, item, amount, favourite}, ...] //
	// //							 // //
// functions for management
	add = function(_item, _amount = 1) {
		var _remainding_amount = _amount;
		var _array_length = array_length(array);
		#region // find matching slot {
			for(var _i = 0; _i < _array_length; _i++) {
				var _index = ptr(array[_i]); // array index pointer
				// check stack not full and matching id
				if (_index.amount != _index.item.stack_size && _index.item.id == _item.id) {
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
				// check stack not full and matching id
				if (_index.amount != _index.item.stack_size && _index.item.id == ITEM.nothing.id) {
					// check stack size
						// remainding space > amount adding
					var _remainding_space = _index.item.stack_size -_index.amount;
					if (_remainding_space > _amount) { 
						_index.amount += _amount
						return; // stack fits, finish adding
					} else {
						_index.amount += _remainding_space;
						_remainding_amount -= _remainding_space;
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
	clear_item = function() {
		array_foreach(array, function(_e, _i) {
			_e.item = ITEM.nothing;
			_e.amount = -1;
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