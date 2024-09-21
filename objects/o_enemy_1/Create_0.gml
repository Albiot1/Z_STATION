move_frame=0
legs_dir=0
dir=0

speed=0.2
spd=0.2
chase_spd=0.3
max_speed=0.5

cdwn=0
maxcdwn=30

dmg_list=ds_list_create()

life=10

brightness=shader_get_uniform(sh_brightness,"powr")  
brightness_power=0 

depth=-y

xvel=0
yvel=0

direction=point_direction(x,y,o_player.x,o_player.y)

arm_spr=spr_zombie_arms1
arm_frame=0

freeze=0
poison=[0,0,0,0] //dmg_time_now,dmg_time,whole_time,dmg_percent
fire=[0,0,0,0]//dmg_time_now,dmg_time,whole_time,dmg
stun=0
bleeding=[0,0,0,0]//dmg_time_now,dmg_time,whole_time,dmg
knockback=[0,0,0,0]//time,power,direction,max_time
//particles
freeze_time=0
freeze_max=35
//particles

state=Z_STATES.IDLE

sight_size=96
idle_wait=0
idle_wait_max=[4,9]
idle_wait=irandom_range(idle_wait_max[0],idle_wait_max[1])*60
move_time=0
move_time_max=[5,8]
lose_range=200

grid_path=path_add()

dir=irandom(360)