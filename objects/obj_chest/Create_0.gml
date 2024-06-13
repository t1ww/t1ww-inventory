/// @description setup
highlight = false; // highlight when mouse on top
// constructor
this_inventory = inventory_create(50,room_height - 300, 10,5,,,);
// init variable
key_interact = null;

/// shader
handler = shader_get_uniform(shd_outline,"texture_Pixel");
handler_1 = shader_get_uniform(shd_outline,"thickness_power");
handler_2 = shader_get_uniform(shd_outline,"RGBA");