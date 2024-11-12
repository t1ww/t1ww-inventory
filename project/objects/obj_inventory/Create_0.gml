/// @description > object event
// Inherit the parent event
event_inherited();
// > code here

// ACTION
	right_click_lock = true;
	action = {
		none: {
			left: function() {
				var _ci = cont_inventory;
				if (_ci.focusing_inventory.array[_ci.focusing_inventory_index].item.id == _ci.mouse.inventory.item.id) {
					// if same item, fill
					_ci.mouse.fill_item();
				} else {
					// else swap
					_ci.mouse.swap_item();
				}
			},
			right: function() {
				// take one, can held down
			}
		},
		shift: {
			left: function() {
				
			},
			right: function() {
					
			}
		},
		alt: {
			left: function() {
				
			},
			right: function() {
					
			}
		},
		control: {
			left: function() {
				
			},
			right: function() {
					
			}
		},
	};