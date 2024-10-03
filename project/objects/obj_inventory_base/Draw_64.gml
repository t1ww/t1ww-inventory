/// @description draw gui -- obj_inventory_base
// code here >
// set font
draw_set_font(fnt_inv_default);
// DRAW INVENTORY OUTLINE (can also think of background)
	var _x_box_right  = x + width;
	var _y_box_bottom = y + height;
	draw_rectangle(x,y , _x_box_right, _y_box_bottom, true);
// draw inventory focusing area
	var _x_last_line  = x + ( (grid_gap + grid_size)* 
		(((array_size mod grids_per_row) == 0)? grids_per_row : (array_size mod grids_per_row)) ) 
		+ grid_gap;
	var c = c_green;
	draw_rectangle_color(x,y , _x_box_right, _y_box_bottom - grid_gap - grid_size, c,c,c,c, true);
		c = c_red;
	draw_rectangle_color(x,_y_box_bottom - (grid_gap*2) - grid_size, _x_last_line, _y_box_bottom, c,c,c,c, true);
// DRAW GRIDS
	var _last_line_size = (((array_size mod grids_per_row) == 0)? grids_per_row : (array_size mod grids_per_row));
	for(var i = 0; i < array_size; i++){
		var _x_index = i mod ((i == array_size)? _last_line_size : grids_per_row);
		var _y_index = i div grids_per_row;
		var _start = { x: x + grid_gap, y: y + grid_gap }
		var _end = { x: _start.x + grid_size, y: _start.y + grid_size }
		// draw grid slot sprite (highlight if on mouse)
		draw_sprite_stretched((cont_inventory.focusing_inventory_index == i)? spr_InvSlotPointer : spr_InvSlot, -1,
			_start.x + (grid_size + grid_gap) * _x_index, 
			_start.y + (grid_size + grid_gap) * _y_index,
			grid_size,
			grid_size
		);
		
		// draw item sprite
		if(array[i].item.id != ITEM.nothing.id){
			draw_sprite_stretched(array[i].item.sprite, -1,
				_start.x + (grid_size + grid_gap) * _x_index, 
				_start.y + (grid_size + grid_gap) * _y_index,
				grid_size,
				grid_size
			);
		}
		// draw amount number
		// at bottom right
			draw_set_halign(fa_right);
			draw_set_valign(fa_bottom);
			draw_text(
				_end.x + (grid_size + grid_gap) * _x_index,
				_end.y + (grid_size + grid_gap) * _y_index,
				(array[i].amount == -1)? "" : $"{(array[i].amount)}"
			);
	}