/// @description > ui mouse draw event
with mouse_inv {
	if(grid[# 0, 0] != 0 && grid[# 0, 0] != null){
		// draw item
		draw_sprite(grid[# 0, 0].sprite,0,x,y);
		// draw amount
		draw_set_valign(fa_middle);
		draw_set_halign(fa_right);
		draw_text(x+60,y+55,string(grid[# 1, 0]));	
	}	
}