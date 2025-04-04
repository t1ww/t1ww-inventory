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
			// Initialize timer struct (only once per instance)
			self[$ "timer_data"] ??= {
				inst: undefined,         // Active timer handle
				interval_start: 20,    // Initial delay
				interval: 20           // Current interval (accelerates over time)
			};
		
			// Handler for held-down loop
			self[$ "to_be_called"] ??= function() {
				var _ci = cont_inventory;
				if (mouse_check_button(mb_right) && _ci.focusing_inventory_index != null) {
					var _inv_item = _ci.focusing_inventory.array[_ci.focusing_inventory_index].item;
		
					// Transfer items
					_ci.mouse.add_item(_inv_item, 1);
					_ci.focusing_inventory.remove_item(_inv_item, _ci.focusing_inventory_index, 1);
		
					// Accelerate timer (min 1 frame)
					self.timer_data.interval = floor(max(
						self.timer_data.interval * 0.75,
						1
					));
		
					// Cancel previous timer if exists
					if (self.timer_data.inst != undefined) call_cancel(self.timer_data.inst);
					
					// Create new timer with updated interval
					self.timer_data.inst = call_later(
						self.timer_data.interval,
						time_source_units_frames,
						self[$ "to_be_called"]
					);
				} else {
					self.timer_data.inst = undefined; // Clear when released
				}
			};
		
			// Handle initial click
			if (mouse_check_button_pressed(mb_right)) {
				var _ci = cont_inventory;
				var _inv_item = _ci.focusing_inventory.array[_ci.focusing_inventory_index].item;
				var _mouse_item = _ci.mouse.inventory.item;
		
				if (_inv_item.id == _mouse_item.id || (_inv_item.id != ITEM.nothing.id && _mouse_item.id == ITEM.nothing.id)) {
					// Initial transfer
					_ci.mouse.add_item(_inv_item, 1);
					_ci.focusing_inventory.remove_item(_inv_item, _ci.focusing_inventory_index, 1);
		
					// Cancel existing timer
					if (self.timer_data.inst != undefined) call_cancel(self.timer_data.inst);
					
					// Reset to initial speed and start
					self.timer_data.interval = self.timer_data.interval_start;
					self.timer_data.inst = call_later(
						self.timer_data.interval,
						time_source_units_frames,
						self[$ "to_be_called"]
					);
				}
			}
		}
	},

	// Shift clicks
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
		// Toggle Favourite
		left: function() {
			if (mouse_check_button_pressed(mb_left)) {
				var _ci = cont_inventory;
				var _ci_index = _ci.focusing_inventory.array[_ci.focusing_inventory_index];
				_ci_index.favourite = !_ci_index.favourite;
				show_debug_message($"Set favourite to {(_ci_index.favourite ? "true" : "false")}");
			}
		},
		// Force Favourite
		right: function() {
			if (mouse_check_button(mb_right)) {
				var _ci = cont_inventory;
				var _ci_index = _ci.focusing_inventory.array[_ci.focusing_inventory_index];
				if (_ci_index.favourite == false) {
					_ci_index.favourite = true;
					show_debug_message("Set favourite to true by right clicks");
				}
			}
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