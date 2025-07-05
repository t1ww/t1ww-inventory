/// @description p_interactible_inventory Step event
// > code here
// Chest interaction
// mouse checking

// Key press to toggle open/close chest
if (keyboard_check_pressed(key_interact)) {
	if (highlight) {
		if (cont_inventory.sub_inventroy == null) {
			// Opening chest
			show_debug_message("Chest open");
			cont_inventory.sub_inventroy = this_inventory;
			cont_inventory.sub_inventroy.active = true;
			cont_inventory.main_inventory.active = true;
		} else if (cont_inventory.sub_inventroy != this_inventory and cont_inventory.sub_inventroy != null) {
			// Changing chest
			show_debug_message("Chest change");
			cont_inventory.sub_inventroy.active = false;
			cont_inventory.sub_inventroy = this_inventory;
			cont_inventory.sub_inventroy.active = true;
		} else if (cont_inventory.sub_inventroy == this_inventory) {
			// Closing chest
			show_debug_message("Chest close");
			cont_inventory.main_inventory.active = false;
			cont_inventory.sub_inventroy.active = false;
			cont_inventory.sub_inventroy = null;
		}
	} else
	if (!obj_chest.highlight and this_inventory.active) {
		// Closing chest
		show_debug_message("Chest close");
		cont_inventory.main_inventory.active = false;
		cont_inventory.sub_inventroy.active = false;
		cont_inventory.sub_inventroy = null;
	}
}
