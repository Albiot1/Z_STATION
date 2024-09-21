room_goto_next()

audio_falloff_set_model(audio_falloff_exponent_distance)
audio_listener_orientation(0,0,-100,0,1,0)

enum CROSSHAIRS {
	NOCROSSHAIR,
	MELEECROSSHAIR,
	NORMAL,
	NORECOIL,
}

enum FIREMODES {
	SEMI_AUTO,
	AUTO,
	BURST_SEMI,
	BURST_AUTO
}
enum PROJMODES {
	NORMAL,
	PATTERN
}
enum DESTROYPOWER {
	MINI,
	SMALL,
	MEDIUM,
	BIG,
	HUGE
}
enum ITEM_TYPE {
	CONSUMABLE,
	WEAPON,
	HEADGEAR,
	CHESTGEAR,
	LEGSGEAR,
	FEETSGEAR,
	COLLECTABLE
}
enum W_TYPE {
	GUN,
	MELEE
}

enum Z_STATES {
	IDLE,
	MOVE,
	CHASE,
	ATTACK,
	SPECIAL,
	SPECIAL1
}

global.language=load_json("gm_assets\\en.json")
randomize()
window_set_cursor(cr_none)

weapons_list = {
bat:
	{
gui_spr:"spr_gun_3",

idle_anim: "spr_player_gun_3_idle",
idle_anim_spd:0.1,
idle_anim_frames:2,

shot_anim: "spr_player_gun_3_shot",
shot_anim_spd:0.15,
shot_anim_frames:3,
shot_sound:-1,
shot_anim_time:1.5, //in frames

screen_shake:[0,0],

ammo_max:1,
ammo:1,
weapon_type:W_TYPE.MELEE,
firerate:10, //cooldownmax
cdwn:0, //cooldown
weight:0.2, //decreases player speed

fire_mode:FIREMODES.SEMI_AUTO,
on_shot: {},
on_reload: {},
count_shots:false,
count_max:1,
shot_num:0,

rifle_pos:[16,0],

show_spread:[-5,5],
show_proj_num:1,
crosshair_type:CROSSHAIRS.MELEECROSSHAIR,

projectiles:
    [
        {spd:0,spr:"spr_melee_hitbox_normal",dmg:2.5,hits:2,spread:[-5,5],bullet_power:[DESTROYPOWER.SMALL,0],invisible:true,lifetime:2,tags:{shake_on_hit:[0.75,3,1],dest_eff:-1}}, //bullet power [ wall dest power , body part destroy ]
	],
    
projectiles_on_shot:
{

mode:PROJMODES.NORMAL,
proj:[0],
num:[1]
    
},

	},
rifle:
	{
gui_spr:"spr_gun_2",

idle_anim: "spr_player_gun_2_idle",
idle_anim_spd:0.1,
idle_anim_frames:2,

reload_anim: "spr_player_gun_2_reload",
reload_anim_spd:0.2,
reload_anim_frames:6,
reload_sound:-1,
reload_anim_time:10, //in frames

shot_anim: "spr_player_gun_2_shot",
shot_anim_spd:0.25,
shot_anim_frames:3,
shot_sound: snd_shot_smg,
shot_anim_time:0.5, //in frames

screen_shake:[0.75,3],
magazine:{spd:[2,3],dir:[-30,30],spr:"spr_mag",obj:"default",pos:[10,-1]},
shell:{spd:[2,4],dir:[-10,10],dir_fix:-90,spr:"spr_shell",obj:"default",pos:[12,-1]},

ammo_max:30,
ammo:30,
weapon_type:W_TYPE.GUN,
firerate:10, //cooldownmax
cdwn:0, //cooldown
weight:0.2, //decreases player speed

fire_mode:FIREMODES.AUTO,
on_shot: {},
on_reload: {},
count_shots:false,
count_max:1,
shot_num:0,

rifle_pos:[10,-1],

show_spread:[-5,5],
show_proj_num:1,
crosshair_type:CROSSHAIRS.NORMAL,

projectiles:
    [
        {spd:[6,7],spr:"spr_bullet",dmg:2.5,hits:2,spread:[-5,5],bullet_power:[DESTROYPOWER.SMALL,0],tags:{dest_eff:{obj:"o_proj_effect"} } }, //bullet power [ wall dest power , body part destroy ]
	],
    
projectiles_on_shot:
{

mode:PROJMODES.NORMAL,
proj:[0],
num:[1]
    
},

	},
gun:
	{
gui_spr:"spr_gun_0",

idle_anim: "spr_player_gun_idle",
idle_anim_spd:0.1,
idle_anim_frames:2,

reload_anim: "spr_player_gun_reload",
reload_anim_spd:0.2,
reload_anim_frames:6,
reload_sound:-1,
reload_anim_time:10, //in frames

shot_anim: "spr_player_gun_shot",
shot_anim_spd:0.15,
shot_anim_frames:3,
shot_sound: snd_shot_pistol,
shot_anim_time:2, //in frames

screen_shake:[0.75,3],
magazine:{spd:[2,3],dir:[-30,30],spr:"spr_mag",obj:"default",pos:[10,-1]},
shell:{spd:[2,4],dir:[-10,10],dir_fix:-90,spr:"spr_shell",obj:"default",pos:[12,-1]},

ammo_max:12,
ammo:12,
weapon_type:W_TYPE.GUN,
firerate:15, //cooldownmax
cdwn:0, //cooldown
weight:0.01, //decreases player speed

fire_mode:FIREMODES.SEMI_AUTO,
on_shot: {},
on_reload: {},
count_shots:true,
count_max:1,
shot_num:0,

burst_max_num:5,
burst_max_time:10,

rifle_pos:[10,-1],

show_spread:[-7,7],
show_proj_num:1,
crosshair_type:CROSSHAIRS.NORMAL,

projectiles:
    [
        {spd:[5,7],spr:"spr_bullet",dmg:2,hits:[1,1.5],spread:[-7,7],bullet_power:[DESTROYPOWER.SMALL,0],tags:{dest_eff:{obj:"o_proj_effect"} }}, //bullet power [ wall dest power , body part destroy ]
	],
    
projectiles_on_shot:
{

mode:PROJMODES.NORMAL,
proj:[0],
num:[1]
    
},

	},
shotgun:
	{
gui_spr:"spr_gun_1",

idle_anim: "spr_player_gun_1_idle",
idle_anim_spd:0.1,
idle_anim_frames:2,

reload_anim: "spr_player_gun_1_reload",
reload_anim_spd:0.2,
reload_anim_frames:15,
reload_sound:-1,
reload_anim_time:25, //in frames

shot_anim: "spr_player_gun_1_shot",
shot_anim_spd:0.15,
shot_anim_frames:3,
shot_sound:snd_shot_shotgun,
shot_anim_time:3, //in frames

screen_shake:[2.5,6],
magazine:{spd:[2,3],dir:[-180-45,-180+45],spr:"spr_shell_1",obj:"default",pos:[10,-1],num:2},

ammo_max:2,
ammo:2,
weapon_type:W_TYPE.GUN,
firerate:40, //cooldownmax
cdwn:0, //cooldown
weight:0.08, //decreases player speed

fire_mode:FIREMODES.SEMI_AUTO,
on_shot: {},
on_reload: {},
count_shots:false,
count_max:1,
shot_num:0,

burst_max_num:5,
burst_max_time:10,

rifle_pos:[10,-1],

show_spread:[-15,15],
show_proj_num:[8,13],
crosshair_type:CROSSHAIRS.NORMAL,

projectiles:
    [
        {spd:[5,7],spr:"spr_bullet",dmg:4.5,hits:2,spread:[-15,15],bullet_power:[DESTROYPOWER.MEDIUM,20],tags:{fallof:[0.07,8,0.2],dest_eff:{obj:"o_proj_effect"} } }, //bullet power [ wall dest power , body part destroy ]
	],

projectiles_on_shot:
{

mode:PROJMODES.NORMAL,
proj:[0],
num:[[8,13]]
    
},

	}
}
	
	
//weapons_list=load_json("gm_assets//weapon_stats.json")
//clipboard_set_text(json_stringify(weapons_list,1))
//show_debug_log(1)