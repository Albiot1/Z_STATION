if place_meeting(x,y,o_player)
{
alpha=lerp(alpha,0.6,0.1)
}
else
{
alpha=lerp(alpha,1,0.1)	
}

depth=-abs(bbox_bottom)