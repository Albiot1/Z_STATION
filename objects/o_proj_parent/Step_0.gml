depth=-abs(y)+50
if instance_place(x,y,o_wall)
{
//audio_play_sound(sfx_sounds_impact3,0,0,0.1)
audio_play_sound_at(sfx_sounds_impact3,x,y,0,50,300,2,false,0,0.1)
var mat=instance_place(x,y,o_wall).material

var cloud_spr=spr_cloud
var destp_spr=spr_rock

switch(mat)
{
case "rock": cloud_spr=spr_cloud destp_spr=spr_rock break;
case "wood": cloud_spr=spr_cloud_wood destp_spr=spr_wood break;
case "ceramic": cloud_spr=spr_cloud destp_spr=spr_ceram break;
}

switch(pow[0])
{
case DESTROYPOWER.MINI: var amount_cloud=[1,2] var scales_cloud=[0.1,0.3] var speed_cloud=[0.20,0.40] var amount_rock=[1,2] var scales_rock=[0.60,0.75] var speed_rock=[0.75,1.25] break;
case DESTROYPOWER.SMALL: var amount_cloud=[2,4] var scales_cloud=[0.3,0.5] var speed_cloud=[0.30,0.60] var amount_rock=[2,4] var scales_rock=[0.70,0.80] var speed_rock=[1.25,1.50] break;
case DESTROYPOWER.MEDIUM: var amount_cloud=[6,10] var scales_cloud=[0.5,0.65] var speed_cloud=[0.40,0.70] var amount_rock=[3,6] var scales_rock=[0.80,0.85] var speed_rock=[1.50,2] break;
case DESTROYPOWER.BIG: var amount_cloud=[12,16] var scales_cloud=[0.70,0.80] var speed_cloud=[0.60,0.90] var amount_rock=[4,6] var scales_rock=[0.85,0.95] var speed_rock=[2.5,3] break;
case DESTROYPOWER.HUGE: var amount_cloud=[25,30] var scales_cloud=[0.9,1.4] var speed_cloud=[0.95,1.20] var amount_rock=[5,8] var scales_rock=[1,1.5] var speed_rock=[4,6.5] break;
}


repeat(irandom_range(amount_cloud[0],amount_cloud[1]))
with instance_create_depth(x-lengthdir_x(5,direction),y-lengthdir_y(5,direction),-1,o_cloud)
{
direction=other.direction-180+irandom_range(-70,70)
sprite_index=cloud_spr
image_xscale=random_range(scales_cloud[0],scales_cloud[1])
image_yscale=image_xscale
speed=random_range(speed_cloud[0],speed_cloud[1])
}

repeat(irandom_range(amount_rock[0],amount_rock[1]))
with instance_create_depth(x-lengthdir_x(5,direction),y-lengthdir_y(5,direction),-1,o_rock)
{
direction=other.direction-180+irandom_range(-70,70)
sprite_index=destp_spr
speed=random_range(speed_rock[0],speed_rock[1])
image_xscale=random_range(scales_rock[0],scales_rock[1])
image_yscale=image_xscale
}


instance_destroy()
}