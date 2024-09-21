image_angle+=speed*10
if (cant_collect>0)
cant_collect--

if (instance_place(x,y,o_wall)){

var coll=instance_place(x,y,o_wall)
speed*=0.95
direction=point_direction(x,y,coll.x,coll.y)-180+irandom_range(-20,20)
	
}