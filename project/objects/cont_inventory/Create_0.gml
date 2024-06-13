/// @description > inventory controller
// handle mouse interactions
global.stack_limit = 9999;
globalvar mouse_inv;
mouse_inv = {
	// variable initialization
	x : 0, y : 0,
	in_area : false,
	active_inv : null,
	active_slot : 0,
	
	#region // timer for mouse holding
	run_timer : false,
	timer : 12,
	rClick_timer : 12,
	rClick_timer_start : 12,
	
	reset_timer : function(){
		rClick_timer_start = timer;
		rClick_timer = timer;
	},
	rClick_start : function(){
		run_timer = true;
	},
	rClick_end : function(){
		run_timer = false;
		reset_timer();
	},
	#endregion
	// grid
	grid : ds_grid_create(2,1), // ([itemid,amount], index)
	
	/// functions
	// item handling
	remove_item : function(index = 0,amount = all){
		if(amount == all || grid[# 1, index] == amount){
			grid[# 0, index] = 0; // set item to none
			grid[# 1, index] = 0; // set amount to 0
			return true;
		}
		if(grid[# 1, index] > amount){
			grid[# 1, index] -= amount;
			if grid[# 1, index] == 0 // empty
			grid[# 0, index] = 0; // set item to none
			return true;
		}
		show_debug_message("cant remove item, amount exeeds the item in the grid")
		return false; // cant remove item, amount exeeds the item in the grid
	},
	add_item : function(_item,_amount = 1){
		grid[# 0,0] = _item;
		grid[# 1,0] = _amount;
	},	
	drop_item : function(_byone = false){ // _one = true to drop only one
		if _byone { // drop item by one
			//create collectible(item,1);
			remove_item(,1);
			show_debug_message("dropped one item from mouse");
		}else{ // // drop item all
			//create collectible(item,amount);
			show_debug_message($"dropped { grid[# 1, 0] } { grid[# 0, 0].name } from mouse");
			// clear mouse
			clear();
		}
	},
	clear : function(){ // remove all
		grid[# 0,0] = 0;
		grid[# 1,0] = 0;
	},
	use_item : function(){
		//(do nothing if consumable = false)
		if grid[# 0, 0].consumable {
			grid[# 1, 0]--; //decrease amount by 1
			grid[# 0, 0].use();//use the item
			if grid[# 1, 0] == 0 {
				clear();
			}
		}
	}, // - end use item function
	// mouse interactions
	update_coord : function(){
		x = device_mouse_x_to_gui(0);
		y = device_mouse_y_to_gui(0);
	},
	// events
	step : function() {
		try{
			update_coord();
			// reset
			active_inv = null;
			in_area = false;
			// try to set
			obj_inventory.get_slot_index();
			obj_inventory.check_inArea();
			/// using items ( not involves with any inventory )
			// mouse isnt on any inventory area and !empty
			var leftClick,rightClick;
			leftClick = mouse_check_button_pressed(mb_left);
			rightClick = mouse_check_button_pressed(mb_right);
			if (!in_area and grid[# 0,0] != 0) {
				if leftClick {// use
					use_item();
				}
				if rightClick {// drop
					drop_item();
				}
			}
			// inventory mouse click handling
			active_inv.mouse_click();
		}catch(e){}
	},
};
ds_grid_clear(mouse_inv.grid, 0);
mouse_inv.reset_timer();
mouse_inv.add_item(ITEM.apple);