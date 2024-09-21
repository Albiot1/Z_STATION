var pdir=point_direction(x,y,mouse_x,mouse_y)


if weap_state!=WSTATES.EQUIPMENT
{
var cweap=weapons[curr_weap]

if cweap!=-1
{

switch(cweap.crosshair_type)
{
case CROSSHAIRS.NORMAL:
var px=cweap.rifle_pos[0]
var py=cweap.rifle_pos[1]
var c_len = point_distance(0, 0, px, py);
var c_ang = point_direction(0, 0, px, py);
px=x + lengthdir_x(c_len, c_ang+pdir)
py=y + lengthdir_y(c_len, c_ang+pdir)

var ps=clamp( point_distance(px,py,mouse_x,mouse_y) , 15 , 1000 )
var sprd=cweap.show_spread

draw_sprite_ext(spr_crosshair_part,0,px+lengthdir_x(ps,pdir-sprd[1]*(1-w_buffs.accuracy)),py+lengthdir_y(ps,pdir-sprd[1]*(1-w_buffs.accuracy)),0.5,0.5,pdir+90,c_white,1)
draw_sprite_ext(spr_crosshair_part,0,px+lengthdir_x(ps,pdir-sprd[0]*(1-w_buffs.accuracy)),py+lengthdir_y(ps,pdir-sprd[0]*(1-w_buffs.accuracy)),0.5,0.5,pdir+90,c_white,1)
draw_sprite_ext(spr_crosshair_dot,0,px+lengthdir_x(ps,pdir),py+lengthdir_y(ps,pdir),0.5,0.5,pdir,c_white,1)
break;
case CROSSHAIRS.NORECOIL:
var px=cweap.rifle_pos[0]
var py=cweap.rifle_pos[1]
var c_len = point_distance(0, 0, px, py);
var c_ang = point_direction(0, 0, px, py);
px=x + lengthdir_x(c_len, c_ang+pdir)
py=y + lengthdir_y(c_len, c_ang+pdir)

var ps=clamp( point_distance(px,py,mouse_x,mouse_y) , 15 , 1000 )

draw_sprite_ext(spr_crosshair,0,px+lengthdir_x(ps,pdir),py+lengthdir_y(ps,pdir),0.5,0.5,pdir,c_white,1)
break;
case CROSSHAIRS.MELEECROSSHAIR:
var px=cweap.rifle_pos[0]
var py=cweap.rifle_pos[1]
var c_len = point_distance(0, 0, px, py);
var c_ang = point_direction(0, 0, px, py);
px=x + lengthdir_x(c_len, c_ang+pdir)
py=y + lengthdir_y(c_len, c_ang+pdir)

var ps=clamp( point_distance(px,py,mouse_x,mouse_y) , 15 , 1000 )

draw_sprite_ext(spr_crosshair_melee,0,px+lengthdir_x(ps,pdir),py+lengthdir_y(ps,pdir),0.5,0.5,pdir-90,c_white,1)
break;
}
/*
var px=cweap.rifle_pos[0]
var py=cweap.rifle_pos[1]
var c_len = point_distance(0, 0, px, py);
var c_ang = point_direction(0, 0, px, py);
px=x + lengthdir_x(c_len, c_ang+pdir)-1
py=y + lengthdir_y(c_len, c_ang+pdir)-1

draw_circle(px,py,1,1)
*/
}
else
{
draw_sprite_ext(spr_eye,0,mouse_x,mouse_y,0.5,0.5,pdir-90,c_white,1)
}


}