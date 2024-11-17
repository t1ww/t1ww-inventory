/// @description create -- obj_inventory_mouse
// Initialization
grid_size = 32;
inventory = { item: ITEM.nothing, amount: -1 };

add = function(_item, _amount = 1) {
    if (inventory.item == ITEM.nothing) {
        inventory.item = _item;
        inventory.amount = _amount;
    } else if (inventory.item != ITEM.nothing) {
        inventory.amount += _amount;
    }
};

remove = function(_amount = 1) {
    if (inventory.item != ITEM.nothing) {
        inventory.amount -= _amount;
    }
};

clear_item = function() {
    inventory.item = ITEM.nothing;
    inventory.amount = -1;
};

// Interaction functions
swap_item = function() {
    // Access the inventory array entry directly using an index
    var _index = cont_inventory.focusing_inventory_index;
    var _array = cont_inventory.focusing_inventory.array;

    // Swap values
    var _temp = { item: inventory.item, amount: inventory.amount };
    inventory.item = _array[_index].item;
    inventory.amount = _array[_index].amount;
    _array[_index].item = _temp.item;
    _array[_index].amount = _temp.amount;
};

fill_item = function() {
    var _index = cont_inventory.focusing_inventory_index;
    var _array = cont_inventory.focusing_inventory.array;

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
    var _index = cont_inventory.focusing_inventory_index;
    var _array = cont_inventory.focusing_inventory.array;

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