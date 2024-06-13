/// @description interaction
// > code here
// mouse checking runs in controller's step event

// key press open/close chest
key_interact = keyboard_check_pressed(ord("E"));
if key_interact {
	if (highlight && !this_inventory.active){
		this_inventory.active = true;
		this_inventory.y = 1500;
	}else
	if !obj_chest.highlight || this_inventory.active {
		this_inventory.active = false;
	}
}
