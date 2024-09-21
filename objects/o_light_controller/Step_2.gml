if instance_exists(o_player)
c_pos=[o_player.camx,o_player.camy]

if surface_exists(surf_col)
{

surface_set_target(surf_col)
draw_clear_alpha(c_black,0)

gpu_set_blendmode(bm_add)
with o_light
{
if color!=$FFFFFFFF
draw_sprite_ext(spr_full,0,x-other.c_pos[0]+320/2,y-other.c_pos[1]+180/2,image_xscale,image_yscale,image_angle,color,color_strength)
}
surface_reset_target()
gpu_set_blendmode(bm_normal)
}
else
{
surf_col=surface_create(320,180)	
}


if surface_exists(surf)
{
	
surface_set_target(surf)
draw_clear_alpha(c_black,darkness)

//gpu_set_blendmode(bm_subtract)



gpu_set_blendmode(bm_subtract)

with o_light
{
draw_sprite_ext(spr,0,x-other.c_pos[0]+320/2,y-other.c_pos[1]+180/2,image_xscale,image_yscale,image_angle,c_white,brightness)
}

gpu_set_blendmode(bm_add)
if surface_exists(surf_col)
draw_surface(surf_col,0,0)
surface_reset_target()
gpu_set_blendmode(bm_normal)
}
else
{
surf_col=surface_create(320,180)
}

