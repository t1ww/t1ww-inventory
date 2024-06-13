/// @description > object event
// > code here
// Inherit the parent event
event_inherited();

// interaction
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
		var _itemid = null;
		try{
			_index = _active_inv.active_slot;
			_itemid = _active_inv.grid[# 0, _index];
		} catch (_e) { 
			// mouse click not ready, do nothing
			exit;
		}
		if(_itemid == 0 and grid[# 0, 0] == 0) {
			exit;
		}else if(_itemid != 0 and _itemid.price > global.wallet) exit;
		/// moving items
		// mouse is on a slot
		if _index != -1 {
			// grid 0,index = item
			// grid 1,index = amount
			if leftClick {
				// if mouse doesnt have item or it does have the same item
				if(grid[# 0, 0] == 0 || grid[# 0, 0] == _itemid) {
					// assigning mouse item (if mouse empty)
					if grid[# 0, 0] == 0 { grid[# 0, 0] = _itemid }
					// take one
					grid[# 1, 0] ++;
					if(_active_inv.grid[# 1, _index] != -1){
						_active_inv.grid[# 1, _index]--;
						if(_active_inv.grid[# 1, _index] == 0){
							_active_inv.grid[# 0, _index] =	0;
						}
					}
					// deduct money
					global.wallet -= _itemid.price ;
				} 
				if _itemid == 0 { // its on empty slot
					// sell item
					global.wallet += (grid[# 0, 0].price * grid[# 1, 0]);
					other.last_sold = [grid[# 0, 0],grid[# 1, 0]];
					clear();
				}
				rClick_end();
			}
		
			// right click
		
			if rightClick {
				rClick_start();
				reset_timer();
				func_rclick();
			} // - end right click
			if rightClickHolding && run_timer {
				if rClick_timer <= 0 {
					func_rclick();
					rClick_timer_start *= .9;
					rClick_timer = rClick_timer_start;
				}
				rClick_timer--;
			} // - end holding rightclick
			if rightClick_release {
				rClick_end();
			}
		} // - active != -1
		
		// right click function
		func_rclick = function(){
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
			var _itemid = null;
			try{
				_index = _active_inv.active_slot;
				_itemid = _active_inv.grid[# 0, _index];
			} catch (_e) { 
				// mouse click not ready, do nothing
				exit;
			}
			// if both empty
			if(_itemid == 0 and grid[# 0, 0] == 0) exit;
			// if mouse dont have item or have the same item
			if(grid[# 0, 0] == 0 || grid[# 0, 0] == _itemid) {
				// assigning mouse item (if mouse empty)
				if grid[# 0, 0] == 0 { grid[# 0, 0] = _itemid }
				// take one
				grid[# 1, 0] ++;
				// deduct money
				global.wallet -= _itemid.price;
			}
		}
	}
}

// buy back
if(last_sold != null)
if(keyboard_check(vk_control) and keyboard_check_pressed(ord("Z"))){
	show_debug_message($"bought back the item {last_sold[1]} {last_sold[0].name}");
	playerinventory.add_item(last_sold[0],last_sold[1]);
	global.wallet -= last_sold[0].price * last_sold[1];
	last_sold = null;
}