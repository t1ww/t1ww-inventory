/// @description > object event

mouse_inv.step();

/// chest handling
// finding the nearest one to mouse to set highlight
with p_interactible_inventory highlight = false; // resetting
var inst = instance_nearest(mouse_x,mouse_y,p_interactible_inventory);
if(point_distance(mouse_x,mouse_y,inst.x,inst.y) < 64){
	inst.highlight = true;	
}