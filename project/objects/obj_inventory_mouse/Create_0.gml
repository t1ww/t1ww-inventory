/// @description create -- obj_inventory_mouse
// code here >
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