/// @description p_interactible_inventory Step event
// > code here
// Chest interaction
// mouse checking

// Key press to toggle open/close chest
if (keyboard_check_pressed(key_interact)) {
	if (highlight && !this_inventory.active) {
		if (cont_inventory.sub_inventroy == null) {
			cont_inventory.sub_inventroy = self;
			cont_inventory.active = true;
		} else if (cont_inventory.sub_inventroy != self and cont_inventory.sub_inventroy != null) {
			cont_inventory.sub_inventroy.active = false;
			cont_inventory.sub_inventroy = self;
			cont_inventory.active = true;
		} else if (cont_inventory.sub_inventroy == self) {
			cont_inventory.sub_inventroy.active = false;
			cont_inventory.sub_inventroy = null;
		}
	} else
	if (!obj_chest.highlight || this_inventory.active) {
		this_inventory.active = false;
	}
}
