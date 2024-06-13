/// @description > object event

if !active exit;

draw();


/// checking in area (draw for debugging)
if(cont_game_test_inventory.debug){
	// variables
	in_area = false;
	var _rows = 0; var _lastRowSize = 0;
	var chk_x, chk_y, mx, my;
	var box_size = sprite_get_width(spr_InvSlot);
	mx = device_mouse_x_to_gui(0);
	my = device_mouse_y_to_gui(0);

	_rows = floor(sizes/wraps);
	_lastRowSize = sizes - (_rows*wraps);
	// checking
	var c = c_green;
	if(orientation == horizontal){
		if(sizes > wraps){ // vertically counting more than one
			// all rows
			draw_rectangle_color(x, 
								 y, 
								 x + ((box_size + gap)*wraps) + edge_gap*2 - gap,
								 y + ((box_size + gap)*_rows) + edge_gap*2 - gap,
			c,c,c,c, true);
			// last row
			if _lastRowSize != 0 {
				c = c_red;
				draw_rectangle_color(x, 
									 y + ((box_size + gap)*_rows) + edge_gap - gap, 
									 x + ((box_size + gap)*_lastRowSize) + edge_gap*2 - gap,
									 y + ((box_size + gap)*(_rows+1)) + edge_gap*2 - gap,
				c,c,c,c, true);
				c = c_green
			}
		} else { // has only one row
			// all rows
			draw_rectangle_color(x, 
								 y, 
								 x + ((box_size + gap)*sizes) + edge_gap*2 - gap,
								 y + (box_size + gap) + edge_gap*2 - gap,
			c,c,c,c, true);
		}
	} else if(orientation == vertical){
		if(sizes > wraps){ // vertically counting more than one
			// all rows
			draw_rectangle_color(x, 
								 y, 
								 x + ((box_size + gap)*_rows) + edge_gap*2 - gap,
								 y + ((box_size + gap)*wraps) + edge_gap*2 - gap,
			c,c,c,c, true);
			// last row
			if _lastRowSize != 0 {
				c = c_red;
				draw_rectangle_color(x + ((box_size + gap)*_rows) + edge_gap - gap, 
									 y, 
									 x + ((box_size + gap)*(_rows+1)) + edge_gap*2 - gap,
									 y + ((box_size + gap)*_lastRowSize) + edge_gap*2 - gap,
				c,c,c,c, true);
				c = c_green
			}
		} else { // has only one row
			// all rows
			draw_rectangle_color(x, 
								 y, 
								 x + ((box_size + gap)*_rows) + edge_gap*2 - gap,
								 y + ((box_size + gap)*wraps) + edge_gap*2 - gap,
			c,c,c,c, true);
		}
	}
}