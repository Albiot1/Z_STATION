

brightness_power+=0.2
life-=other.dmg
instance_destroy(other.id)

var dir=irandom(360)
repeat(irandom_range(1,3))
with instance_create_depth(x,y,-1,o_blood_0)
{
direction=dir+irandom_range(-30,30)
}

if life<0
{

if weap_state!=WSTATES.EQUIPMENT
{
var pdir=point_direction(x,y,mouse_x,mouse_y)
}
else
{
var pdir=last_mouse_dir	
}

with instance_create_depth(x,y,-1,o_enemy)
	{
		direction=pdir
	}
instance_destroy()
}