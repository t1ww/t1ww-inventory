/// @description > object event
// > code here
// swap hotbar
if(current_hotbar == itemhotbar){
	current_hotbar = weaponhotbar;
	weaponhotbar.active = true;
	itemhotbar.active = false;
}else {
	current_hotbar = itemhotbar;
	itemhotbar.active = true;
	weaponhotbar.active = false;
}