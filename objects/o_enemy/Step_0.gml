if freeze>0
{
speed=0
freeze--
freeze_time++
if freeze_time>=freeze_max
	{
with instance_create_depth(irandom_range(bbox_left,bbox_right),irandom_range(bbox_top,bbox_bottom),depth-1,o_freeze_cloud) {direction=irandom_range(0,360) image_angle=direction speed=random_range(0.8,1.2)}
freeze_max=irandom_range(30,65)
freeze_time=0
	}
}

if stun>0
{
speed=0
stun--
}

if freeze>0 or stun>0
exit;

if cdwn<maxcdwn and state!=Z_STATES.ATTACK
{
cdwn++
}

depth=-abs(y)
move_frame+=0.1*(speed/max_speed)

if brightness_power>0
brightness_power-=0.1

var _colliding = collision_circle(x, y, 6, o_wall, 0, 1);

if _colliding {
var _dir = point_direction(_colliding.x, _colliding.y, x, y)+irandom_range(-30,30)
xvel += lengthdir_x(0.2, _dir);
yvel += lengthdir_y(0.2, _dir);
}

#region pushing
var coll = instance_place(x, y, o_player);
if coll {

var _dir = point_direction(coll.x, coll.y, x, y)
xvel += lengthdir_x(0.05, _dir);
yvel += lengthdir_y(0.05, _dir);

}
var coll = instance_place(x, y, o_enemy);

if coll {
var _dir = point_direction(coll.x, coll.y, x, y)
xvel += lengthdir_x(0.1, _dir);
yvel += lengthdir_y(0.1, _dir);
}
#endregion

#region knockback
if knockback[0]>0
{
var knock_pow=knockback[1]*( clamp(knockback[0]/knockback[3]+0.1,0.1,1 ) )
xvel += lengthdir_x(knock_pow, knockback[2]);
yvel += lengthdir_y(knock_pow, knockback[2]);
knockback[0]--
}

if !place_meeting(x+xvel,y+yvel,o_wall)
{
x+=xvel
y+=yvel
}
else
{
if knockback[0]>0
	{
knockback[2]=point_direction(x,y,x+xvel,y+yvel)-180+irandom_range(-30,30)
	}
xvel=0
yvel=0
}

xvel*=0.9
yvel*=0.9
#endregion

switch(state)
{
case Z_STATES.IDLE:
arm_spr=spr_zombie_arms

speed=0

if idle_wait>0
{
idle_wait--
}

if idle_wait<=0
{
state=Z_STATES.MOVE
move_time=irandom_range(move_time_max[0],move_time_max[1])*60
}

if instance_exists(o_player)
		{
var player_in_=collision_circle(x,y,sight_size,o_player,0,1)
if player_in_ and !collision_line(x,y,o_player.x,o_player.y,o_wall,0,1)
{
state=Z_STATES.CHASE
}
else if collision_line(x,y,o_player.x,o_player.y,o_wall,0,1) and collision_circle(x,y,sight_size*0.75,o_player,0,1)
{
state=Z_STATES.CHASE	
}
		}

break;	
case Z_STATES.MOVE:

if collision_line(x,y,x+lengthdir_x(14,direction+60),y+lengthdir_y(14,direction+60),o_wall,0,1)
direction-=6
if collision_line(x,y,x+lengthdir_x(9,direction+45),y+lengthdir_y(9,direction+45),o_wall,0,1)
direction-=12
else if collision_line(x,y,x+lengthdir_x(9,direction-45),y+lengthdir_y(9,direction-45),o_wall,0,1)
direction+=12
if collision_line(x,y,x+lengthdir_x(14,direction-60),y+lengthdir_y(14,direction-60),o_wall,0,1)
direction+=6

speed=lerp(speed,spd,0.1)

dir=direction

if move_time>0
{
move_time--
}

if move_time<=0
{
state=Z_STATES.IDLE
idle_wait=irandom_range(idle_wait_max[0],idle_wait_max[1])*60
}

if instance_exists(o_player)
		{
var player_in_=collision_circle(x,y,sight_size,o_player,0,1)
if player_in_ and !collision_line(x,y,o_player.x,o_player.y,o_wall,0,1)
{
state=Z_STATES.CHASE
}
else if collision_line(x,y,o_player.x,o_player.y,o_wall,0,1) and collision_circle(x,y,sight_size*0.75,o_player,0,1)
{
state=Z_STATES.CHASE	
}
		}

break;
case Z_STATES.CHASE:
if instance_exists(o_player)
	{
speed=lerp(speed,chase_spd,0.1)

if mp_grid_path(global.grid,grid_path,x,y,o_player.x,o_player.y,1)
{
var nxt_x=path_get_point_x(grid_path,1)
var nxt_y=path_get_point_y(grid_path,1)

direction=point_direction(xprevious,yprevious,nxt_x,nxt_y)
dir= point_direction(x,y,o_player.x,o_player.y)//angle_difference( dir,point_direction(x,y,o_player.x,o_player.y) )*0.1

if path_get_length(grid_path)>=lose_range
state=Z_STATES.IDLE
}
else
{
state=Z_STATES.IDLE	
}

if collision_circle(x,y,16,o_player,0,1) and cdwn>=maxcdwn
{
arm_frame=0
state=Z_STATES.ATTACK
}
	}
else
	{
state=Z_STATES.IDLE	
	}
break;
case Z_STATES.ATTACK:

speed=0

if cdwn>=maxcdwn
	{
	cdwn=0
	arm_spr=spr_zombie_arms_atk
	arm_frame=0
	}

if arm_frame>=3.8 and arm_spr=spr_zombie_arms_atk
{
	
	with instance_create_depth(x,y,-1,o_z_proj)
	{
	dmg=2
	image_angle=other.dir
	alarm[0]=2
	}
	
	arm_spr=spr_zombie_arms
	state=Z_STATES.MOVE
	if instance_exists(o_player)
			{
	var player_in_=collision_circle(x,y,sight_size,o_player,0,1)
	if player_in_ and !collision_line(x,y,o_player.x,o_player.y,o_wall,0,1)
	{
	state=Z_STATES.CHASE
	}
	else if collision_line(x,y,o_player.x,o_player.y,o_wall,0,1) and collision_circle(x,y,sight_size*0.75,o_player,0,1)
	{
	state=Z_STATES.CHASE	
	}
			}
}

break;
	
}

arm_frame+=0.1
if arm_frame>=sprite_get_number(arm_spr)
arm_frame=0


//knockback=[10,2,point_direction(x,y,o_player.x,o_player.y)-180,10]