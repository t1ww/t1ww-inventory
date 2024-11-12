/// @description > object event
// Inherit the parent event
event_inherited();
// > code here

// ACTION
	right_click_lock = true;
	action = {
		none: {
			left: function() {
				// if same item, fill
				cont_inventory.mouse.swap_item();
				// else swap
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