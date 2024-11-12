/// @description create -- obj_inventory_mouse
// code here >
grid_size = 32;
inventory = { item: ITEM.nothing, amount: -1 };
//
add = function(_item, _amount = 1) {
	if(inventory.item == ITEM.nothing) {
		inventory.item = _item;
		inventory.amount = _amount;
	} else 
	if(inventory.item != ITEM.nothing) {
		inventory.amount += _amount;
	}
}
remove = function(_amount = 1) {
	if(inventory.item != ITEM.nothing) {
		inventory.amount -= _amount;
	}
}
clear_item = function() {
	inventory.item   = ITEM.nothing;
	inventory.amount = -1;
}
// interaction functions
swap_item = function() {
	var _index = ptr(cont_inventory.focusing_inventory.array[cont_inventory.focusing_inventory_index]);
	var _temp = { item: inventory.item, amount : inventory.amount }; 
	inventory.item = _index.item;
	inventory.amount = _index.amount;
	_index.item = _temp.item;
	_index.amount = _temp.amount;
}

fill_item = function() {
	var _index = ptr(cont_inventory.focusing_inventory.array[cont_inventory.focusing_inventory_index]);
	if ((inventory.amount + _index.amount)> inventory.item.stack_size) {
		// OVERFLOW
		inventory.amount -= inventory.item.stack_size - _index.amount;
		_index.amount = _index.item.stack_size;
	} else {
		// FIT	
		_index.amount += inventory.amount;
		clear_item();
	}
}
take_item = function() {
	// take item one by one
	
	// set _index item to ITEM.nothing when amount reach 0
}