/// @description create -- obj_inventory_mouse
// Initialization
grid_size = 32;
inventory = { item: ITEM.nothing, amount: -1 };

add_item = function(_item, _amount = 1) {
    if (inventory.item.id == ITEM.nothing.id) {
        inventory.item = _item;
        inventory.amount = _amount;
    } else if (inventory.item.id != ITEM.nothing.id) {
		// Make sure it's the same item
		if(inventory.item.id == _item.id) {
			inventory.amount += _amount;
		} else {
			show_debug_message("Adding denied: Attempted to add a different item to mouse");
		}
    }
};

remove_item = function(_amount = 1) {
	show_debug_message($"Calling mouse's remove_item({_amount})");
	// Make sure it's possible
	if (_amount > inventory.amount) {
		// not possible, return false (can be used for amount check)
		show_debug_message("Failed to call remove_item(): insufficient amount in inventory");
		return false;
	}
	
    if (inventory.item.id != ITEM.nothing.id) {
        inventory.amount -= _amount;
    }
	// Set item to nothing when it reach zero
	if (inventory.amount == 0) {
		inventory.item = ITEM.nothing;	
	}
	// Removed successfully
	return true;
};

clear_item = function() {
	show_debug_message("Calling mouse's clear_item()");
    inventory.item = ITEM.nothing;
    inventory.amount = -1;
};

use_item = function() {
    if (inventory.item != ITEM.nothing) {
        show_debug_message("Calling mouse's use_item()");
		inventory.item.use();
		remove_item();
	} else {
        show_debug_message("Calling mouse's use_item() but it's empty");
    }
}

// Interaction functions
swap_item = function() {
    // Access the inventory array entry directly using an index
    var _inventory_id = cont_inventory.focusing_inventory.id;
    var _index = cont_inventory.focusing_inventory_index;
    var _array = cont_inventory.focusing_inventory.array;
    show_debug_message($"Calling mouse's swap_item at inventory: {_inventory_id}, index: {_index}");

    // Swap values
    var _temp = { item: inventory.item, amount: inventory.amount };
    inventory.item = _array[_index].item;
    inventory.amount = _array[_index].amount;
    _array[_index].item = _temp.item;
    _array[_index].amount = _temp.amount;
};

fill_item = function() {
    var _inventory_id = cont_inventory.focusing_inventory.id;
    var _index = cont_inventory.focusing_inventory_index;
    var _array = cont_inventory.focusing_inventory.array;
    show_debug_message($"Calling mouse's fill_item at inventory: {_inventory_id}, index: {_index}");

    if ((inventory.amount + _array[_index].amount) > inventory.item.stack_size) {
        // Overflow case
        inventory.amount -= inventory.item.stack_size - _array[_index].amount;
        _array[_index].amount = _array[_index].item.stack_size;
    } else {
        // Fit case
        _array[_index].amount += inventory.amount;
        clear_item();
    }
};

take_item = function() {
    var _inventory_id = cont_inventory.focusing_inventory.id;
    var _index = cont_inventory.focusing_inventory_index;
    var _array = cont_inventory.focusing_inventory.array;
    show_debug_message($"Calling mouse's take_item at inventory: {_inventory_id}, index: {_index}");

    // Take one item at a time
    if (_array[_index].amount > 0) {
        inventory.item = _array[_index].item;
        inventory.amount += 1;
        _array[_index].amount -= 1;

        // Clear source if empty
        if (_array[_index].amount == 0) {
            _array[_index].item = ITEM.nothing;
        }
    }
};