/// @description > object event
// > code here
// Inherit the parent event
event_inherited();

// override the inv skin
slot_sprite = spr_MarketSlot;
last_sold = null; // might want to turn this into a list

// *** grid([itemid, amount = -1], index) ***

// set add_item to not stack with pre, existing item
// overriding the mouseclick
// buy item on rightclick, sell item on leftclick