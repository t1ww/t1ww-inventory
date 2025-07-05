/// @description p_interactable_inventory Create event
highlight = false; // Highlight when mouse on top
// constructor
this_inventory = instance_create_layer(200,300, "inventory", obj_inventory);
// init variable
key_interact = (ord("E"));

/// shader
handler = shader_get_uniform(shd_outline,"texture_Pixel");
handler_1 = shader_get_uniform(shd_outline,"thickness_power");
handler_2 = shader_get_uniform(shd_outline,"RGBA");