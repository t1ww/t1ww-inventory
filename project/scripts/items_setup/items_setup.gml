/// /*Scripts @ desc items setup
// code here >
enum item_type {
	none,
	/// consumables
	special,potion,food,
	/// weapons
	//melee
	sword,claymore,
	dagger,glove, // can dual wield
	//ranged
	bow,repeater,
	gun,rocket,grenade,
	//mage
	staff,tome,
	//summoner
	dart,whip,
	/// equipment
	armor,equipment,
	/// permanent upgrade
	quiver,mag,bag, // arrow, bullet, dart
	hpcrystal,manastar, // limited
	hpgem,managem // unlimited
	
	// for counting
	,total
}
global.item = {};
#macro ITEM global.item
with(ITEM) {
	/// creating items
	nothing = {
		id : -1,
		name : "nothing",
		type : item_type.none,
		sprite : spr_item_setup,
	}
	// consumable example
	apple = {
		id : 1,
		name		: "apple",
		description : "grows on tree",
		tool_tip	: "+1 hp",
		sprite		: spr_apple,
		type		: item_type.food,
		consumable	: true,
		material	: false,
		stack_size	: 9999,
		price		: 10,
		use : function(){
			show_debug_message("used apple");
			// eat(); // run eating state / animation?
			// hp += 1;
		}
	};
	// equipment example
	hat = {
		id : 2,
		name		: "hat",
		description : "wear it on your head",
		tool_tip	: "+1 def",
		sprite		: spr_hat,
		type		: item_type.armor,
		consumable	: false,
		material	: false,
		stack_size	: 1,
		price		: 25,
		equip : function(){
			show_debug_message("wearing a hat");
			def += 1;
		},
		dequip : function(){
			def -=1;
		},
	};
}
// crafting recipe
	// should overwrite every items used "material -> true;"
	// maybe create a function to add a revcipe
//
