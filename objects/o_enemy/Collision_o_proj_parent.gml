var coll=instance_place(x,y,o_proj_parent)
if !(ds_list_find_index(dmg_list,coll)>=0) 
	{
if coll.hits>1
ds_list_add(dmg_list,coll)

if state!=Z_STATES.ATTACK and state!=Z_STATES.CHASE and point_distance(x,y,o_player.x,o_player.y)<lose_range
{
state=Z_STATES.CHASE	
}

var dir=irandom(360)
repeat(irandom_range(4,10))
with instance_create_depth(x,y,-1,o_blood_0)
{
direction=dir+irandom_range(-30,30)
}

var c_dmg=coll.dmg
if variable_struct_exists(coll.tags,"fallof")
{
c_dmg=clamp( coll.dmg-( (coll.dmg*coll.tags.fallof[0])*(point_distance(x,y,coll.xstart,coll.ystart)/coll.tags.fallof[1] ) ) , coll.dmg*coll.tags.fallof[2], coll.dmg )
}
if variable_struct_exists(coll.tags,"shake_on_hit")
{
shake_add(coll.tags.shake_on_hit[0],coll.tags.shake_on_hit[1])
coll.tags.shake_on_hit[2]--
if coll.tags.shake_on_hit[2]<=0
variable_struct_remove(coll.tags,"shake_on_hit")
}

if variable_struct_exists(coll.tags,"on_hit")
{
coll.tags.on_hit(c_dmg)
}

show_debug_message("HIT:"+string(c_dmg))

life-=c_dmg
coll.hits-=random_range(1,1.75)
if coll.hits<=0
instance_destroy(coll)
brightness_power=0.5

if life<=0
instance_destroy()
	}
