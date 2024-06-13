/// @description > object event
// > code here


// Inherit the parent event
event_inherited();

/// setting the hotbar index
// keybind
key_pressed = (
	(keyboard_key >= ord("0") && keyboard_key <= ord(string(sizes)))
	? keyboard_key - ord("0")
	: -1 //else
);
if key_pressed != -1
	hotbar_index = key_pressed-1;
if keyboard_check_pressed(ord("Z")){
	hotbar_index = -1;	
}
// scroll
if(mouse_wheel_up()){
	if(++hotbar_index > sizes-1){
		hotbar_index = 0;	
	}
}
if(mouse_wheel_down()){
	if(--hotbar_index < 0){
		hotbar_index = sizes-1;	
	}
}
/// using the item
if(hotbar_index != -1)
if(mouse_inv.grid[# 0,0] == 0 and grid[# 0,hotbar_index] != 0 and !mouse_inv.in_area){
	// use item
	use_item(hotbar_index);
}