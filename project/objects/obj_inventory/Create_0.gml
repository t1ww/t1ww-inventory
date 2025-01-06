/// @description > object event
// Inherit the parent event
event_inherited();
// > code here

// ACTION
	right_click_lock = true;
	action = {
		none: {
			left: function() {
				if (mouse_check_button_pressed(mb_left)) {
					var _ci = cont_inventory;
					if (_ci.focusing_inventory.array[_ci.focusing_inventory_index].item.id == _ci.mouse.inventory.item.id) {
						// if same item, fill
						_ci.mouse.fill_item();
					} else {
						// else swap
						_ci.mouse.swap_item();
					}
				}
			},
			right: function() {
				// Take one, can held down
				
				// Initialize the timer
				self[$ "timer_interval_start"] ??= 30;
				self[$ "timer_interval "] ??= timer_interval_start;
				
				// Function for handling the held down loop
				to_be_called = function() {
					var _ci = cont_inventory;
					if (mouse_check_button(mb_right) and _ci.focusing_inventory_index != null) {
						var _inv_item = _ci.focusing_inventory.array[_ci.focusing_inventory_index].item;
						// Take one item from inventory to mouse
						_ci.mouse.add_item(_inv_item, 1);
						// Gradually get faster
						var _cap = 1;
						timer_interval = floor(max(timer_interval*.75, _cap));
						call_later(timer_interval, time_source_units_frames, to_be_called);
					}
				}
				
				// Handling right click
				if (mouse_check_button_pressed(mb_right)) {
					// If same item or inventory has item and mouse is empty
					var _ci = cont_inventory;
					var _inv_item = _ci.focusing_inventory.array[_ci.focusing_inventory_index].item;
					var _mouse_item = _ci.mouse.inventory.item;

					if (_inv_item.id == _mouse_item.id || (_inv_item.id != ITEM.nothing.id && _mouse_item.id == ITEM.nothing.id)) {
						// Take one
						_ci.mouse.add_item(_inv_item, 1);
						_ci.focusing_inventory.remove_item(_mouse_item, _ci.focusing_inventory_index, 1);
						// Start timer
						timer_interval = timer_interval_start;
						call_later(timer_interval, time_source_units_frames, to_be_called);
					}
				}
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