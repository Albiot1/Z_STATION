image_xscale=lerp(image_xscale,0,0.01)
image_yscale=image_xscale

image_angle+=speed*10

if image_xscale<=0.1
instance_destroy()


if instance_place(x,y,o_wall)
{

var coll=instance_place(x,y,o_wall)
speed*=0.95
direction=point_direction(x,y,coll.x,coll.y)-180+irandom_range(-20,20)
	
}