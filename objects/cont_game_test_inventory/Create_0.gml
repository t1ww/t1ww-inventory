/// @description game setup and debugger
// You can write your code in this editor
draw_set_font(fnt);
depth = -999;
debug = false;

#macro null undefined

/// creating playerInvetory
	globalvar playerinventory, equipmentinventory;
	playerinventory = inventory_create(50,100,21,10,horizontal); //player's inventory
	playerinventory.active = true;
	equipmentinventory = inventory_create(1100,100,5,1,horizontal,[item_type.armor], true);
/// creating player's hotbar
	globalvar itemhotbar;
	itemhotbar = hotbar_create(50,20,5,10,horizontal);
	itemhotbar.active = true;
	globalvar weaponhotbar;
	weaponhotbar = hotbar_create(50,20,2,10,horizontal);
/// toggle inventory 
	toggle_hub = true;
	
hub_list = [playerinventory, equipmentinventory];
reset_active = function(){
	array_foreach(hub_list,function(_element,_index){
		_element.active = cont_game_test_inventory.toggle_hub;
	})
}
//window_set_fullscreen(true);

// setting up for hotbar 
current_hotbar = itemhotbar;

// money wallet
global.wallet = 5000;