/// @description > object event
// > code here


// draw item sprite
	if(inventory.item.id != ITEM.nothing.id){
		draw_sprite_stretched(inventory.item.sprite, -1,
			mouse_gui_x, 
			mouse_gui_y,
			grid_size,
			grid_size
		);
	}
// draw amount number
// at bottom right
	draw_set_halign(fa_right);
	draw_set_valign(fa_bottom);
	draw_text(
		mouse_gui_x + grid_size, 
		mouse_gui_y + grid_size,
		(inventory.amount == -1)? "" : $"{(inventory.amount)}"
	);