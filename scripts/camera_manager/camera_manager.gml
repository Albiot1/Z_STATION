function camera_manager() {

if weap_state!=WSTATES.EQUIPMENT
{
var cam_dir=point_direction(x,y,mouse_x,mouse_y)
var mpx=device_mouse_x_to_gui(0)
var mpy=device_mouse_y_to_gui(0)
var cam_pos=point_distance(455/2,256/2,mpx/3,mpy/3)/4
var cam_target_pos_x=lengthdir_x( cam_pos,cam_dir )
var cam_target_pos_y=lengthdir_y( cam_pos,cam_dir )
}
else
{
var cam_dir=last_mouse_dir	
var mpx=last_mouse_pos[0]
var mpy=last_mouse_pos[1]
var cam_pos=point_distance(455/2,256/2,mpx/3,mpy/3)/4
var cam_target_pos_x=lengthdir_x( cam_pos,cam_dir )
var cam_target_pos_y=lengthdir_y( cam_pos,cam_dir )
}


if weap_state!=WSTATES.EQUIPMENT
{
camx=lerp(camx,x+cam_target_pos_x,0.1)
camy=lerp(camy,y+cam_target_pos_y,0.1)
}

var shake_c=0
if array_length(global.shake)>0
{

for(var i=array_length(global.shake)-1;i>=0;i--) //delete already eneded shaking
	{
if global.shake_time[i]>0
global.shake_time[i]--
if global.shake_time[i]<=0
{
array_delete(global.shake,i,1)
array_delete(global.shake_time,i,1)
}
	}
	
for(var i=0;i<array_length(global.shake);i++) //delete already eneded shaking
	{
shake_c+=global.shake[i]
	}

}

var _len = random_range( shake_c/3,shake_c )
var _dir= random(360)
var x_off=lengthdir_x(_len,_dir)
var y_off=lengthdir_y(_len,_dir)

//camera_set_view_pos(view_camera[0],camx-camsize[0]+random_range(-shake_c,shake_c),camy-camsize[1]+random_range(-shake_c,shake_c))
camera_set_view_pos(view_camera[0],camx-camsize[0]+x_off,camy-camsize[1]+y_off)

}