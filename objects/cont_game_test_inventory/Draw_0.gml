/// @description game setup and debugger
if debug {
	try {
		var m = mouse_inv;
		with m {
		//drawing debugger
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);
			draw_text(x+60,y,"in area : " + string(in_area));
			draw_text(x+60,y+15,"active slot : " 
				+ string((active_inv == null)? "null": active_inv.active_slot)
			);
			draw_text(x+60,y+30,"item : " + string(grid[# 0,0]));
			draw_text(x+60,y+45,"amount : " + string(grid[# 1,0]));
		}
	}catch(e){}
}