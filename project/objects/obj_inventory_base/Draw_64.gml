/// @description draw gui -- obj_inventory_base
// code here >
// DRAW INVENTORY OUTLINE (can also think of background)
	var _x_box_right  = x + ( (grid_gap + grid_size)* min(array_size, grid_line_limit)   ) + grid_gap;
	var _y_box_bottom = y + ( (grid_gap + grid_size)*((array_size div grid_line_limit)+1)) + grid_gap;
	var _x_last_line  = x + ( (grid_gap + grid_size)* 
		(((array_size mod grid_line_limit) == 0)? grid_line_limit : (array_size mod grid_line_limit)) ) 
		+ grid_gap;
	draw_rectangle(x,y , _x_box_right, _y_box_bottom, true);
// draw debug (inventory focusing area)
	var c = c_green;
	draw_rectangle_color(x,y , _x_box_right, _y_box_bottom - grid_gap - grid_size, c,c,c,c, true);
		c = c_red;
	draw_rectangle_color(x,_y_box_bottom - (grid_gap*2) - grid_size, _x_last_line, _y_box_bottom, c,c,c,c, true);
// DRAW GRIDS
	var _last_line_size = (((array_size mod grid_line_limit) == 0)? grid_line_limit : (array_size mod grid_line_limit));
	for(var i = 0; i < array_size; i++){
		var _x_index = i mod ((i == array_size)? _last_line_size : grid_line_limit);
		var _y_index = i div grid_line_limit;
		var _start = { x: x+grid_gap, y: y+grid_gap }
		// draw grid slot sprite
		draw_sprite_stretched(spr_InvSlot, 0,
			_start.x + (grid_size + grid_gap) * _x_index, 
			_start.y + (grid_size + grid_gap) * _y_index,
			grid_size,
			grid_size
		);
		// draw item sprite
		if(array[i].item.id != ITEM.nothing.id){
			draw_sprite_stretched(array[i].item.sprite, 0,
				_start.x + (grid_size + grid_gap) * _x_index, 
				_start.y + (grid_size + grid_gap) * _y_index,
				grid_size,
				grid_size
			);
		}
		// draw amount number
			draw_text(_start.x + (grid_size + grid_gap) * _x_index,
						_start.y + (grid_size + grid_gap) * _y_index,
						$"{array[i].amount}"
			);
	}