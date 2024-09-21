
shader_set(sh_brightness)
shader_set_uniform_f(brightness,brightness_power)

if freeze<=0
draw_sprite_ext(spr_zombie_legs,move_frame,x,y,1,1,legs_dir,c_white,1)
else
draw_sprite_ext_color(spr_zombie_legs,move_frame,x,y,1,1,legs_dir,1,c_aqua,0.4)

if freeze<=0
draw_sprite_ext(arm_spr,arm_frame,x,y,1,1,dir+5*(sin(move_frame)),c_white,1)
else
draw_sprite_ext_color(arm_spr,arm_frame,x,y,1,1,dir+5*(sin(move_frame)),1,c_aqua,0.4)

if freeze<=0
draw_sprite_ext(sprite_index,image_index,x,y,1,1,dir+5*(sin(move_frame)),c_white,1)
else
draw_sprite_ext_color(sprite_index,image_index,x,y,1,1,dir+5*(sin(move_frame)),1,c_aqua,0.4)

shader_reset()
//draw_line(x,y,x+lengthdir_x(5,legs_dir),y+lengthdir_y(5,legs_dir))
//draw_text(x,y-32,legs_dir)

if stun>0
draw_sprite(spr_zombie_stun,current_time/100,x,y)
//draw_circle(x+lengthdir_x(12,direction-40)-1,y+lengthdir_y(12,direction-40)-1,2,1)
//draw_circle(x+lengthdir_x(12,direction+40)-1,y+lengthdir_y(12,direction+40)-1,2,1)

draw_path(grid_path,x,y,0)
var st_=state
switch(st_)
{
case Z_STATES.IDLE: st_="IDLE" break;	
case Z_STATES.MOVE: st_="MOVE" break;	
case Z_STATES.CHASE: st_="CHASE" break;	
case Z_STATES.ATTACK: st_="ATTACK" break;	
case Z_STATES.SPECIAL: st_="SPECIAL" break;	
}
draw_text(x,y,st_)