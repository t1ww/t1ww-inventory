/// @description > inventory step event
	
// moving
if(x != x_fixed or y != y_fixed){
	x = lerp(x,x_fixed,.1);
	y = lerp(y,y_fixed,.1);
}