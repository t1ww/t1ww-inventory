/// @description > object event
// > code here


// Inherit the parent event
event_inherited();

type_limitation = [];
hotbar_index = 0;

set_draw(function(slot_sprite = spr_InvSlot, background = noone){
	// draw setup
		draw_set_valign(fa_middle);
		draw_set_halign(fa_right);
		//draw background
		if(background != noone){
			draw_sprite(background,0,x,y);
		}
		//draw every slots
		var slotCount = 0;
		var i = 0,j = 0;
		while(slotCount < sizes){
			if(wraps != -1 && i >= wraps){
				// wrap (reset x count, + y count)
				i = 0;
				j++;
			}
			var highlight = (active_slot == slotCount)? true : false;
			draw_set_color(c_white);
			if highlight { 
				// set shader when mouse on
				shader_set(shd_slot_highlight);
				draw_set_color(c_black);
			} 
			//start origin from coord + edge gap
			var at;
			at = {	
				x: x + edge_gap + (i*(64+gap)),
				y: y + edge_gap + (j*(64+gap))
			};
			// draw each slots
			draw_sprite(slot_sprite,(hotbar_index == slotCount)? 1 : 0,at.x,at.y);
			if highlight { shader_reset();}
			// if the slot is not empty
			if(grid[# 0, slotCount] != null && grid[# 0, slotCount] != 0){
				// draw item
				draw_sprite(grid[# 0, slotCount].sprite,0,at.x,at.y);
				// draw amount
				draw_set_valign(fa_middle);
				draw_set_halign(fa_right);
				draw_text(at.x+60,at.y+55,string(grid[# 1, slotCount]));	
			}
			slotCount++;
			i++;
		}	
});