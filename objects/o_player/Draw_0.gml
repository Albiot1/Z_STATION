if weap_state!=WSTATES.EQUIPMENT
{
var pdir=point_direction(x,y,mouse_x,mouse_y)
}
else
{
var pdir=last_mouse_dir	
}
var cweap=weapons[curr_weap]

shader_set(sh_brightness)
shader_set_uniform_f(brightness,brightness_power)
draw_sprite_ext(spr_player_legs,move_frame,x,y,1,1,legs_dir,c_white,1)


switch(weap_state)
{
case WSTATES.INTERACT:
if interact_spr!=-1
	{
var img_num=sprite_get_number(interact_spr)
if keyboard_check(keys.interact)
	{
if frame<img_num
frame+=0.2
else if frame>=img_num
frame=0
	}
draw_sprite_ext(interact_spr,frame,x,y,1,1,pdir,c_white,1)
	}
break;

case WSTATES.EQUIPMENT:
var img=spr_player_idle
var img_spd=0.2
var img_num=2

if frame<img_num
frame+=img_spd
else if frame>=img_num
frame=0

draw_sprite_ext(img,frame,x,y,1,1,pdir,c_white,1)
break;
case WSTATES.IDLE: 

if cweap==-1
	{
var img=spr_player_idle
var img_spd=0.2
var img_num=2

if frame<img_num
frame+=img_spd
else if frame>=img_num
frame=0

draw_sprite_ext(img,frame,x,y,1,1,pdir,c_white,1)
	}
else 
	{
var img=get_spr(cweap.idle_anim)
var img_spd=cweap.idle_anim_spd
var img_num=cweap.idle_anim_frames

if frame<img_num
frame+=img_spd
else if frame>=img_num
frame=0

draw_sprite_ext(img,frame,x,y,1,1,pdir,c_white,1)
	}
break;
case WSTATES.SHOT:

if cweap==-1
	{
weap_state=WSTATES.IDLE
	}
else 
	{
var img=get_spr(cweap.shot_anim)
var img_spd=cweap.shot_anim_spd
var img_num=cweap.shot_anim_frames
var img_time=cweap.shot_anim_time*(1-w_buffs.firerate)

if frame_time<=img_time
{
frame=clamp( (frame_time/img_time)*img_num,0,img_num)
frame_time+=img_spd
}
else
{
shell_dropped=0
frame=0
frame_time=0
weap_state=WSTATES.IDLE
}

draw_sprite_ext(img,frame,x,y,1,1,pdir,c_white,1)
	}
break;
case WSTATES.RELOAD: 

if cweap==-1
	{
weap_state=WSTATES.IDLE
	}
else 
	{
var img=get_spr(cweap.reload_anim)
var img_spd=cweap.reload_anim_spd
var img_num=cweap.reload_anim_frames
var img_time=cweap.reload_anim_time-cweap.reload_anim_time*w_buffs.reload_speed

if frame_time<img_time
{
frame=clamp( (frame_time/img_time)*img_num,0,img_num)
frame_time+=img_spd
}
else
{
frame=0
frame_time=0

var reload_num=0
var max_reload=cweap.ammo_max*(1+w_buffs.ammo_multi)

cweap.ammo=max_reload

//if variable_struct_exists(cweap,"on_reload")
//cweap.on_reload()

weap_state=WSTATES.IDLE
}
draw_sprite_ext(img,frame,x,y,1,1,pdir,c_white,1)
	}

break;
}

draw_sprite_ext(body_spr,0,x,y,1,1,pdir,c_white,1)
draw_sprite_ext(head_spr,0,x,y,1,1,pdir,c_white,1)

shader_reset()
//draw_line(x,y,x+lengthdir_x(5,legs_dir),y+lengthdir_y(5,legs_dir))
//draw_text(x,y-32,legs_dir)

/*
var PX=cweap.shell.pos[0]
var PY=cweap.shell.pos[1]
var PD=cweap.shell.pos[2]
var c_len = point_distance(0, 0, PX, PY);
var c_ang = point_direction(0, 0, PX, PY);

draw_line(x,y,x + lengthdir_x(c_len, c_ang+pdir)-1, y + lengthdir_y(c_len, c_ang+pdir)-1)
*/

