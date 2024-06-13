/// @description > object event
// > code here
if(keyboard_check(vk_control)){
	if(keyboard_check_pressed(ord("S"))){
		inventory_save("playerinv.inv",playerinventory);	
	}
	if(keyboard_check_pressed(ord("L"))){
		with(playerinventory){instance_destroy();}
		playerinventory = inventory_load("playerinv.inv");	
		hub_list = [playerinventory, equipmentinventory];
		reset_active();
	}
}