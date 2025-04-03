/// @description > object event
// Inherit the parent event
event_inherited();
// > code here

// ACTION
action = {
	// Basic actions
	none: {
		// Take, fill, or swap full items
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
		// Take one, can held down
		right: function() {
		    // Initialize timer settings correctly
		    self[$ "timer_interval_start"] ??= 20; // Initial delay
		    self[$ "timer_interval"] ??= self[$ "timer_interval_start"]; // Fixed typo and reference

		    // Function for handling held down loop
		    to_be_called = function() {
		        var _ci = cont_inventory;
		        // Only continue if holding right button and valid slot
		        if (mouse_check_button(mb_right) && _ci.focusing_inventory_index != null) {
		            var _inv_item = _ci.focusing_inventory.array[_ci.focusing_inventory_index].item;
           
		            // Add to mouse and remove from inventory
		            _ci.mouse.add_item(_inv_item, 1);
		            _ci.focusing_inventory.remove_item(_inv_item, _ci.focusing_inventory_index, 1); // Fixed removal item

		            // Accelerate timer but clamp minimum speed
		            var _cap = 1;
		            self[$ "timer_interval"] = floor(max(self[$ "timer_interval"] * 0.75, _cap));
           
		            // Cancel any previous timer before creating new one
		            if (self[$ "timer_id"] != undefined) call_cancel(self[$ "timer_id"]);
		            self[$ "timer_id"] = call_later(self[$ "timer_interval"], time_source_units_frames, to_be_called);
		        } else {
		            // Clear timer ID when button is released
		            self[$ "timer_id"] = undefined;
		        }
		    };

		    // Handle initial right click press
		    if (mouse_check_button_pressed(mb_right)) {
		        var _ci = cont_inventory;
		        var _inv_item = _ci.focusing_inventory.array[_ci.focusing_inventory_index].item;
		        var _mouse_item = _ci.mouse.inventory.item;

		        // Check if items are compatible
		        if (_inv_item.id == _mouse_item.id || (_inv_item.id != ITEM.nothing.id && _mouse_item.id == ITEM.nothing.id)) {
		            // Transfer items
		            _ci.mouse.add_item(_inv_item, 1);
		            _ci.focusing_inventory.remove_item(_inv_item, _ci.focusing_inventory_index, 1); // Fixed removal item

		            // Cancel any existing timer before starting new
		            if (self[$ "timer_id"] != undefined) call_cancel(self[$ "timer_id"]);
           
		            // Reset interval and start timer
		            self[$ "timer_interval"] = self[$ "timer_interval_start"];
		            self[$ "timer_id"] = call_later(self[$ "timer_interval"], time_source_units_frames, to_be_called);
		        }
		    }
		}
	},
	shift: {
		// Transfer item to another inventory (if opened)
		left: function() {
			
		},
		// Take half
		right: function() {
			// Handling right click
			if (mouse_check_button_pressed(mb_right)) {
				// If same item or inventory has item and mouse is empty
				var _ci = cont_inventory;
				var _ci_index = _ci.focusing_inventory.array[_ci.focusing_inventory_index];
				var _inv_item = _ci_index.item;
				var _mouse_item = _ci.mouse.inventory.item;

				if (_inv_item.id == _mouse_item.id || (_inv_item.id != ITEM.nothing.id && _mouse_item.id == ITEM.nothing.id)) {
					// Take Half // and if stack not limited
					var _amount_half = ceil(_ci_index.amount*.5);
					_ci.mouse.add_item(_inv_item, _amount_half);
					_ci.focusing_inventory.remove_item(
						_mouse_item, _ci.focusing_inventory_index, _amount_half
					);
				}
			}
		}
	},
	// Marking favourite
	alt: {
		left: function() {
			
		},
		right: function() {
				
		}
	},
	// Trashing / Selling
	control: {
		left: function() {
			
		},
		right: function() {
				
		}
	},
};