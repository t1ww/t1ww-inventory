/// @description testing keybinds -- cont_game_test_inventory
// event : step
// code here >
if (keyboard_check_pressed(input.inventory_toggle)) {
	main_inventory.active = !main_inventory.active;	
}