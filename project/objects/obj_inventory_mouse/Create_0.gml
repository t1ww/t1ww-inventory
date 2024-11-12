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
remove = function(_item, _amount = 1) {
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
	var _temp = {item: inventory.item, amount : inventory.amount}; 
	inventory.item = _index.item;
	inventory.amount = _index.amount;
	_index.item = _temp.item;
	_index.amount = _temp.amount;
	
}
fill_item = function() {}
