/// @description desc
// code here >
	list = ds_list_create();
	list_focus_index = -1;
	// [{item, amount, favourite}, ...] //
	// //							 // //
// functions for management
	add = function(_item, _amount = 1) {
		var _remainding_amount = _amount;
		#region // find matching slot {
			for(var _i = 0; _i < ds_list_size(list); _i++) {
				var _index = ptr(list[| _i]); // list index pointer
				// check stack not full and matching id
				if( _index.amount != _index.item.stack_size && _index.item.id == _item.id) {
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
		
		#endregion }
		// else is inventory is full
		show_debug_message($"ref: '{self}' inventory is full while trying to add");
		if(inventory.item == ITEM.nothing) {
			inventory.item = _item;
			inventory.amount = _amount;
		} else 
		if(inventory.item != ITEM.nothing) {
			inventory.amount += _amount;
		}
	}
	remove = function(_item, _amount = 1) {
		if(inventory.item != ITEM.nothing) {
			inventory.amount -= _amount;
		}
	}
	clear_item = function() {
		inventory.item   = ITEM.nothing;
		inventory.amount = -1;
	}