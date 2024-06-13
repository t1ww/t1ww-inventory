/// @description > inventory create event

// initialization
	// configs
	orientation     = horizontal;
	type_limitation = null;
	x_fixed = x;
	y_fixed = y;
	sizes   = 0;
	wraps   = 0;
	grid = ds_grid_create(3,sizes); // ( [itemid,amount,favourite(boolean)] , index )
	// cleaning
	ds_grid_clear(grid, 0);
	
// Set Defaults
	x = 1000;
	y = 1000;
	active_slot = -1;
	active  = false;
	in_area = false;
	// draw setting
	slot_sprite = spr_InvSlot;
	background  = spr_InvBackground;
	
// functions //
	// setters
	set_wraps = function(_wraps){
		wraps = _wraps;
		return self;
	}
	set_size  = function(_size){
		resize(_size);
		return self;
	}
	set_orientation = function(_or){
		orientation = _or;	
		return self;
	}
	set_type_limitation = function(_typeLimitArray){
		type_limitation = _typeLimitArray;
		return self;
	}
	// loading
	set_grid = function(_grid){
		// load inventory
		var _keys = variable_struct_get_names(ITEM);
		var _item_struct_length = array_length(_keys);
		var _item, _key;
		// inventory loop
		for(var i = 0; i < ds_grid_height(grid); i++) {
			_item = _grid[# 0, i];
			
			if(_item == 0) continue; // inventory loop
			// item loop
			for (var _item_index = 0; _item_index < _item_struct_length; _item_index++ ) {
				 var _key_name = _keys[_item_index];
				 
				 _key = ITEM[$ _key_name];
				 // set item value
				 if (_item.id == _key.id) {
					 show_debug_message("setting " + _key_name);
					// set item value
					grid[# 0, i] = _key;
					// set item amount
					grid[# 1, i] = _grid[# 1, i];
					// set favourite
					grid[# 2, i] = _grid[# 2, i];
					
					break; // item loop
				}	
			}
			
		}
		return self;
	}
	
	// item managing
	add_item = function(itemid,a = 1){
		var amount; amount = a;
		var stack_limit = global.stack_limit;
		show_debug_message("adding " + itemid.name);
		//iterate to all index to see if can stack up the item
		for(var i = 0; i < sizes; i++){
			if(grid[# 0, i] == itemid and grid[# 1, i] != stack_limit){// if its the same item and not full
				if(amount + grid[# 1, i] > stack_limit){
					var grid_amount = grid[# 1, i];
					grid[# 1, i] = stack_limit; // adds to stack
					amount = amount - (stack_limit - grid_amount);
				}else{
					grid[# 1, i] += amount; // adds by amount
					return true; // item set done
				} // 1, stack = 5, add by 10, remaining = 10-4 = 6
			}
		}
		//put in free space instead
		for(var i = 0; i < sizes; i++){
			if(grid[# 0, i] == 0){// if its empty
				// overrides item id and amount
				grid[# 0, i] = itemid;
				grid[# 1, i] = amount;
				return true; // item set done
			}
		}
		// cant add remaining amount
		// create dropped item with remaining amount
		show_debug_message($"adding failed, dropping remaining {itemid.name} with amount : {amount}");
		return false; // item is not set
	}
	remove_item = function(index = 0, amount = all){
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
	}
	// //
	use_item = function(_index){
		//(do nothing if consumable = false)
		if grid[# 0, _index].consumable {
			if(mouse_check_button_pressed(mb_left)){
				grid[# 0, _index].use();//use the item
				remove_item(_index, 1);
			}
		}
	}
		
	// clear // remove all
	clear = function(slot_index){
		remove_item(slot_index,);
	}
		
	// expanding / resizing grid size
	resize = function(amount = 1){
		sizes = amount;
		ds_grid_resize(grid,2,sizes);
		return self;
	}
	expand = function(amount = 1){
		sizes += amount;
		ds_grid_resize(grid,2,sizes);
		return self;
	}
		
	//draw // draw the inventory and check in_area
	draw = function(){
		// draw setup
		draw_set_valign(fa_middle);
		draw_set_halign(fa_right);
		//draw background
		draw_sprite(background,0,x,y);
		
		//draw every slots
		var slotCount = 0;
		var i = 0,j = 0;
		if ( orientation == horizontal ) {
			while(slotCount < sizes){
				if(wraps != -1 && i >= wraps){ // count slot on x
					//reset
					i = 0;
					j++;
				}
				// draw each item slots
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
				draw_sprite(slot_sprite,0,at.x,at.y);
				if highlight { shader_reset(); }
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
		} else if ( orientation == vertical ) {
			while(slotCount < sizes){
				if(wraps != -1 && i >= wraps){ // count slot on x
					//reset
					i = 0;
					j++;
				}
				// draw each item slots
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
					x: x + edge_gap + (j*(64+gap)),
					y: y + edge_gap + (i*(64+gap))
				};
				draw_sprite(slot_sprite,0,at.x,at.y);
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
		}
	}
	
	set_draw = function(_func){
		draw = _func;	
	}

	
// interaction
get_slot_index = function(){
	with(obj_inventory){
		// only run while active
		if (active){
			// finding slot
			var slotCount = 0;
			var i = 0;
			var j = 0;
			active_slot = -1;
			if ( orientation == horizontal ) {
				while(slotCount < sizes){
					if(wraps != -1 && i >= wraps){ // count slot on x
						//reset
						i = 0;
						j++;
					}
					//start origin from coord + edge gap
					var at;
					at = {	
						x: x + edge_gap + (i*(64+gap)),
						y: y + edge_gap + (j*(64+gap))
					};
					chk_x = (device_mouse_x_to_gui(0) > at.x && 
								device_mouse_x_to_gui(0) < at.x + 64);
					chk_y = (device_mouse_y_to_gui(0) > at.y &&
								device_mouse_y_to_gui(0) < at.y + 64);
					if chk_x && chk_y {
						active_slot = slotCount;
						mouse_inv.active_inv = id; // set access to the mouse
					}
					slotCount++;
					i++;
				}	
			} 
			else 
			if ( orientation == vertical ) {
			// finding slot
				while(slotCount < sizes){
					if(wraps != -1 && i >= wraps){ // count slot on x
						//reset
						i = 0;
						j++;
					}
					//start origin from coord + edge gap
					var at;
					at = {	
						x: x + edge_gap + (j*(64+gap)),
						y: y + edge_gap + (i*(64+gap))
					};
					chk_x = (device_mouse_x_to_gui(0) > at.x && 
								device_mouse_x_to_gui(0) < at.x + 64);
					chk_y = (device_mouse_y_to_gui(0) > at.y &&
								device_mouse_y_to_gui(0) < at.y + 64);
					if chk_x && chk_y {
						active_slot = slotCount;
						mouse_inv.active_inv = id; // set access to the mouse
					}
					slotCount++;
					i++;
				}		
			}
		}
	}
}

check_inArea = function() {
	with(obj_inventory){
		// only run while active
		if active {
			/// checking in area variable (for use item function)
			// variables
			var _rows = 0; var _lastRowSize = 0;
			var chk_x, chk_y, mx, my;
			var box_size = 64;
			mx = device_mouse_x_to_gui(0);
			my = device_mouse_y_to_gui(0);
			// rows calculation
			_rows = floor(sizes/wraps);
			_lastRowSize = sizes - (_rows*wraps);

			// checking
			if(orientation == horizontal){
				if(sizes > wraps){ // vertically counting more than one
					// all rows
					chk_x = (mx > x && 
							 mx < x + ((box_size + gap)*wraps) + edge_gap*2 - gap);
					chk_y = (my > y && 
							 my < y + ((box_size + gap)*_rows) + edge_gap*2 - gap);
					if(chk_x && chk_y){mouse_inv.in_area = true; return;}
					if(!in_area && _lastRowSize != 0){
						// last row ( only run when haven't got in area)
						chk_x = (mx > x && 
								 mx < x + ((box_size + gap)*_lastRowSize) + edge_gap*2 - gap);
						chk_y = (my > y + ((box_size + gap)*_rows) + edge_gap - gap && 
								 my < y + ((box_size + gap)*(_rows+1)	) + edge_gap*2 - gap);
						if(chk_x && chk_y){mouse_inv.in_area = true; return;}
					}
				} else { // has only one row
					// all rows
					chk_x = (mx > x && 
							 mx < x + ((box_size + gap)*sizes) + edge_gap*2 - gap);
					chk_y = (my > y && 
							 my < y + (box_size + gap) + edge_gap*2 - gap);
					if(chk_x && chk_y){mouse_inv.in_area = true; return;}
				}
			}
			else
			if(orientation == vertical){
				if(sizes > wraps){ // vertically counting more than one
					// all rows
					chk_x = (mx > x && 
							 mx < x + ((box_size + gap)*_rows) + edge_gap*2 - gap);
					chk_y = (my > y && 
							 my < y + ((box_size + gap)*wraps) + edge_gap*2 - gap);
					if(chk_x && chk_y){mouse_inv.in_area = true; return;}
					if(!in_area && _lastRowSize != 0){
						// last row ( only run when haven't got in area)
						chk_x = (mx > x + ((box_size + gap)*_rows) + edge_gap - gap && 
								 mx < x + ((box_size + gap)*(_rows+1)	) + edge_gap*2 - gap);
						chk_y = (my > y && 
								 my < y + ((box_size + gap)*_lastRowSize) + edge_gap*2 - gap);
						if(chk_x && chk_y){mouse_inv.in_area = true; return;}
					}
				} else { // has only one row
					// all rows
					chk_x = (mx > x && 
							 mx < x + (box_size + gap) + edge_gap*2 - gap);
					chk_y = (my > y && 
							 my < y + ((box_size + gap)*sizes) + edge_gap*2 - gap);
					if(chk_x && chk_y){mouse_inv.in_area = true; return;}
				}
			}
		}
	}
}
	
mouse_click = function(){
	with(mouse_inv){
		#region// mouse check variables
		
		var leftClick,rightClick,rightClickHolding,rightClick_release,shift,alt,
			_active_inv,_index;
		// checking
		leftClick = mouse_check_button_pressed(mb_left);
		rightClick = mouse_check_button_pressed(mb_right);
		rightClickHolding = mouse_check_button(mb_right);
		rightClick_release = mouse_check_button_released(mb_right);
		shift = keyboard_check(vk_shift);
		alt = keyboard_check(vk_alt);
		_active_inv = mouse_inv.active_inv;
		
		#endregion
		/// check for inv index on mouse
		// stop if mouse isnt on any inventory's slots or mouse has nothing
		try {
			_index = _active_inv.active_slot;
		} catch (_e) { 
			// mouse click not ready, do nothing
			exit;
		}
		if(_active_inv.grid[# 0, _index] == 0 and grid[# 0, 0] == 0) exit;
		// type limitation
		if(other.type_limitation != null){
			var type_matched = false;
				// type is matched with any in array, match = true
				for(var i = 0; i < array_length(other.type_limitation); i++){
					if(grid[# 0, 0] == 0 || grid[# 0, 0].type == other.type_limitation[i])
						type_matched = true;
				}
			if (type_matched) == false {
				if(mouse_check_button_pressed(mb_left)) show_debug_message("type mismatched for inventory");
				exit;
			}
		}
			
		/// / moving items
		// mouse is on a slot
		if (_index == -1) exit; 
		/* 
		 grid 0,index = item
		 grid 1,index = amount
		*/
		// left-click handling
		if (leftClick) {
			if (shift) {
				//push item at mouse hover to the opening container
			} else {
				// if mouse != slot
				if(grid[# 0, 0] != _active_inv.grid[# 0, _index]) { 
					// swap item
					var temp = 0;
					//swap item id
					temp = grid[# 0, 0];
					grid[# 0, 0] = _active_inv.grid[# 0, _index];
					_active_inv.grid[# 0, _index] = temp;
					//swap item amount
					temp = grid[# 1, 0];
					grid[# 1, 0] = _active_inv.grid[# 1, _index];
					_active_inv.grid[# 1, _index] = temp;					
					show_debug_message("swapped item from slot " + string(_index) + " with mouse");
				// if mouse == slot and not full
				}else if(grid[# 0, 0] == _active_inv.grid[# 0, _index] 
				and _active_inv.grid[# 1, _index] < global.stack_limit
				and grid[# 0, 0].stackable == true) { 
					// put all item in mouse into slot
					_active_inv.grid[# 1, _index] += grid[# 1, 0];
					// if over flow, buffer it down
					if _active_inv.grid[# 1, _index] > global.stack_limit {
						var a;
						a = _active_inv.grid[# 1, _index];
						grid[# 1, 0] = a - global.stack_limit; // set mouse amount to the remainings
						_active_inv.grid[# 1, _index] = global.stack_limit; // set slot amount to stack limit 
					}else clear();
					show_debug_message("added mouse's item to slot " + string(_index));
				}
			}
			rClick_end();
		}
		
		// right-click handling
		if (rightClick) {
			rClick_start();
			reset_timer();
			func_rclick();
		} // - end right click
		if (rightClickHolding && run_timer) {
			if rClick_timer <= 0 {
				func_rclick();
				rClick_timer_start *= .9;
				rClick_timer = rClick_timer_start;
			}
			rClick_timer--;
		} // - end holding rightclick
		if (rightClick_release) {
			rClick_end();
		}
		
		
		// right click function
		static func_rclick = function(){
			#region// mouse check variables
				var leftClick,rightClick,rightClickHolding,rightClick_release,shift,alt,
					_active_inv,_index;
				// checking
				leftClick = mouse_check_button_pressed(mb_left);
				rightClick = mouse_check_button_pressed(mb_right);
				rightClickHolding = mouse_check_button(mb_right);
				rightClick_release = mouse_check_button_released(mb_right);
				shift = keyboard_check(vk_shift);
				alt = keyboard_check(vk_alt);
				_active_inv = mouse_inv.active_inv;
			#endregion
			// stop if mouse isnt on any inventory's slots or mouse has nothing
			try{
				_index = _active_inv.active_slot;
			} catch (_e) { 
				// mouse click not ready, do nothing
				exit;
			}
			if(_active_inv.grid[# 0, _index] == 0 and grid[# 0, 0] == 0) exit;
			//
			// if mouse empty or (has the same item and stackable)
			if	(grid[# 0, 0] == 0 
				or (grid[# 0, 0] == _active_inv.grid[# 0, _index] 
					and grid[# 0, 0].stackable == true)
				) 
			{
			// assigning mouse item
				if grid[# 0, 0] == 0 { grid[# 0, 0] = _active_inv.grid[# 0, _index] }
				// if holding shift pick half
				if shift {
					var _amt;
					_amt = ceil(_active_inv.grid[# 1, _index]/2);
					grid[# 0, 0] = _active_inv.grid[# 0, _index];
					grid[# 1, 0] += _amt;
					_active_inv.remove_item(_index,_amt);
				}else{ // not holding shift
				// take one
					grid[# 1, 0] ++;
					_active_inv.remove_item(_index,1);
				}
			}
		}
	}
}