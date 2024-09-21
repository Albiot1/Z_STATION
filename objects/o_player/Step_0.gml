audio_listener_position(x,y,0)

if regen_amnt>0 and life<max_life
{
if regen_cdwn<regen_cdwn_max
regen_cdwn++
else
	{
	regen_cdwn=0
	life+=regen_amnt
	if life>max_life
	life=max_life
	}
}

if weap_state!=WSTATES.EQUIPMENT
{
var pdir=point_direction(x,y,mouse_x,mouse_y)
}
else
{
var pdir=last_mouse_dir	
}
var cweap=weapons[curr_weap]

if cweap==-1
{
var cweight=0	
}
else 
{
var cweight=cweap.weight	
}

var speed_now=spd-cweight*(1-w_buffs.weight_reduction)

movement(speed_now+spd_buff)

depth=-abs(y)

camera_manager()

switch(weap_state)
{
case WSTATES.EQUIPMENT:
if keyboard_check_pressed(keys.backpack)
{
weap_state=WSTATES.IDLE
cursor_sprite=-1//spr_crosshair
}
break;
case WSTATES.INTERACT:

if instance_exists(interact_id) and collision_circle(x+lengthdir_x(5,pdir),y+lengthdir_y(5,pdir),4,interact_id,0,1)
	{
	if keyboard_check(keys.interact)
			{
	if interact_id.interaction_time<interact_id.interaction_max_time
	interact_id.interaction_time++
	else
	{
	interact_id=-1
	interact_spr=-1
	weap_state=WSTATES.IDLE		
	}
			}
	}
else
	{
	if instance_exists(interact_id)
		{
		interact_id.interaction_time=0
		}
	interact_id=-1
	interact_spr=-1
	weap_state=WSTATES.IDLE
	}
	
break;
case WSTATES.IDLE:
if keyboard_check_pressed(keys.backpack)
{
weap_state=WSTATES.EQUIPMENT
cursor_sprite=spr_cursor_hand
last_mouse_pos=[device_mouse_x_to_gui(0),device_mouse_y_to_gui(0)]
last_mouse_dir=pdir
}

if mouse_wheel_down()
{
curr_weap++
if curr_weap>2
curr_weap=0
}
if mouse_wheel_up()
{
curr_weap--	
if curr_weap<0
curr_weap=2
}

// INTERACTIONS
if collision_circle(x+lengthdir_x(5,pdir),y+lengthdir_y(5,pdir),4,o_interactive,0,1)
{
var inter_list=ds_list_create()	
var num=collision_circle_list(x+lengthdir_x(5,pdir),y+lengthdir_y(5,pdir),4,o_interactive,0,1,inter_list,0)
var highest=0
var current_id=-1
var c_depth=0

for(var i=0;i<num;i++)
{
var idc=ds_list_find_value(inter_list,i)
if (idc.depth<c_depth or i==0) and idc.interactable==true
	{
current_id=idc
c_depth=idc.depth
	}
}

if current_id!=-1
{
	interact_id=current_id
	interact_spr=current_id.interaction_spr
	weap_state=WSTATES.INTERACT
}

}
//
if cweap==-1
{
}
else
	{
if cweap.cdwn<cweap.firerate and burst_num<=0
cweap.cdwn++

var check=0

switch(cweap.fire_mode)
{
case FIREMODES.AUTO: 
if mouse_check_button(mb_left) and cweap.cdwn>=cweap.firerate*(1-w_buffs.firerate) //normal fire so check if player presses a lmb
check=1 
break;
case FIREMODES.BURST_AUTO:
if mouse_check_button(mb_left) and burst_num==0 and cweap.cdwn>=cweap.firerate*(1-w_buffs.firerate) //burst fire
{ //check is 1 set burst number to max 
check=1
burst_num=cweap.burst_max_num
burst_time=0
}
else if burst_num>0 and burst_time>=cweap.burst_max_time
{
check=1
burst_time=0
burst_num--
}
break;
case FIREMODES.BURST_SEMI:
if mouse_check_button_pressed(mb_left) and burst_num==0 and cweap.cdwn>=cweap.firerate*(1-w_buffs.firerate) //burst fire
{ //check is 1 set burst number to max 
check=1
burst_num=cweap.burst_max_num
burst_time=0
}
else if burst_num>0 and burst_time>=cweap.burst_max_time
{
check=1
burst_time=0
burst_num--
}
break;
case FIREMODES.SEMI_AUTO:
if mouse_check_button_pressed(mb_left) and cweap.cdwn>=cweap.firerate*(1-w_buffs.firerate) //normal fire so check if player presses a lmb
check=1 
break;
}

if check==1 and (cweap.ammo>0 or cweap.weapon_type==W_TYPE.MELEE)
	{
cweap.cdwn=0

if variable_struct_exists(cweap,"shell")
	{
var shell_num=1
if variable_struct_exists(cweap.shell,"num")
{
shell_num= array_stat(cweap.shell.num	)
}
repeat(shell_num)
		{
var shell_spd=random_range( cweap.shell.spd[0],cweap.shell.spd[1] )
var shell_dir=random_range( cweap.shell.dir[0],cweap.shell.dir[1] )
var shell_spr=get_spr(cweap.shell.spr)
var shell_fix=cweap.shell.dir_fix
var obj=cweap.shell.obj
if obj=="default"
obj=o_shell

var px=cweap.shell.pos[0]
var py=cweap.shell.pos[1]
var c_len = point_distance(0, 0, px, py);
var c_ang = point_direction(0, 0, px, py);


with instance_create_depth(x + lengthdir_x(c_len, c_ang+pdir)-1, y + lengthdir_y(c_len, c_ang+pdir)-1,-1,obj)
{
speed=shell_spd
direction=pdir+shell_fix+shell_dir
image_angle=direction
sprite_index=shell_spr
}
		}
	}

shake_add(cweap.screen_shake[0],cweap.screen_shake[1])

//if variable_struct_exists(cweap,"on_shot")
//cweap.on_shot()

if cweap.weapon_type!=W_TYPE.MELEE
cweap.ammo--

var px=cweap.rifle_pos[0]
var py=cweap.rifle_pos[1]
var c_len = point_distance(0, 0, px, py);
var c_ang = point_direction(0, 0, px, py);
px=x + lengthdir_x(c_len, c_ang+pdir)-1
py=y + lengthdir_y(c_len, c_ang+pdir)-1

switch(cweap.projectiles_on_shot.mode)
{
case PROJMODES.NORMAL: 
for(var i=0;i<array_length(cweap.projectiles_on_shot.num);i++)
{
if is_array(cweap.projectiles_on_shot.num[i])
var repeat_=irandom_range( cweap.projectiles_on_shot.num[i][0], cweap.projectiles_on_shot.num[i][1] )*(1+w_buffs.proj_multi)
else 
var repeat_=cweap.projectiles_on_shot.num[i]*(1+w_buffs.proj_multi)

repeat(repeat_)
proj_create(px,py,pdir,cweap.projectiles[cweap.projectiles_on_shot.proj[i]])	
}
break;
case PROJMODES.PATTERN:
for(var i=0;i<array_length(cweap.projectiles_on_shot.num[cweap.shot_num]);i++)
{
if is_array(cweap.projectiles_on_shot.num[cweap.shot_num][i])
var repeat_=irandom_range( cweap.projectiles_on_shot.num[cweap.shot_num][i][0], cweap.projectiles_on_shot.num[cweap.shot_num][i][1] )*(1+w_buffs.proj_multi)
else 
var repeat_=cweap.projectiles_on_shot.num[cweap.shot_num][i]*(1+w_buffs.proj_multi)

repeat(repeat_)
proj_create(px,py,pdir,cweap.projectiles[cweap.projectiles_on_shot.proj[cweap.shot_num][i]])
}
break;
}

if cweap.count_shots==true
{
cweap.shot_num++
if cweap.shot_num>cweap.count_max
cweap.shot_num=0
}

if cweap.shot_sound!=-1
audio_play_sound(cweap.shot_sound,0,0)

weap_state=WSTATES.SHOT
frame=0
frame_time=0
	}
	
if cweap.ammo<cweap.ammo_max and keyboard_check_pressed(ord("R"))
{
	
if variable_struct_exists(cweap,"magazine")
	{
var repeat_num=1

if variable_struct_exists(cweap.magazine,"num")
repeat_num= array_stat(cweap.magazine.num)

repeat(repeat_num)
		{
var mag_spd=random_range( cweap.magazine.spd[0],cweap.magazine.spd[1] )
var mag_dir=random_range( cweap.magazine.dir[0],cweap.magazine.dir[1] )
var mag_spr=get_spr(cweap.magazine.spr)
var obj=cweap.magazine.obj
if obj=="default"
obj=o_mag

var px=cweap.magazine.pos[0]
var py=cweap.magazine.pos[1]
var c_len = point_distance(0, 0, px, py);
var c_ang = point_direction(0, 0, px, py);


with instance_create_depth(x + lengthdir_x(c_len, c_ang+pdir)-1, y + lengthdir_y(c_len, c_ang+pdir)-1,-1,obj)
{
speed=mag_spd
direction=pdir+mag_dir
image_angle=direction
sprite_index=mag_spr
}
		}
	}

weap_state=WSTATES.RELOAD
}
	}
break;
case WSTATES.SHOT: 

break;
case WSTATES.RELOAD: 

break;
}

if brightness_power>0
brightness_power-=0.1

life_fake=lerp(life_fake,life,0.1)

if instance_place(x,y,o_item)
{
var item_id=instance_place(x,y,o_item)
show_debug_message("ITEM!"+string(item_id.cant_collect))
if item_id.cant_collect<=0
	{
var can_pick=check_free_slots()
if can_pick!=undefined
	{
add_alert("PICKED UP: "+item_id.your_item.name,100)
inventory.item[ can_pick ]=item_id.your_item
instance_destroy(item_id)
	}

	}
}

life_lerp=lerp(life_lerp,life,0.1)