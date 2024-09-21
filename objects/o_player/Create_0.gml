enum WSTATES {
	IDLE,
	SHOT,
	RELOAD,
	INTERACT,
	EQUIPMENT
}

enum EQUIPMENT_MENUS {
INVENTORY,
BESTIARY,
SETTINGS
}

enum SLOT_TYPE {
	NORMAL=0,
	WEAPON=1,
	WEAPON_1=2,
	WEAPON_2=3,
	HEADGEAR=4,
	CHESTGEAR=5,
	LEGSGEAR=6,
	FEETSGEAR=7,
	THRASH=8,
}

cursor_sprite=-1//spr_crosshair

move_frame=0
legs_dir=0

vsp=0
hsp=0
max_hsp=2
max_vsp=2
sliperness=0
additional_spd=0


spd=0.5
spd_buff=0
defense=0

keys={
left: ord("A"),
right: ord("D"),
up: ord("W"),
down: ord("S"),
reload: ord("R"),
shot: mb_left,
spec_shot: mb_right,
interact: ord("E"),
backpack: vk_tab,
dialog_skip: vk_enter,
}

items_list = {
	pistol_ammo_box:{drop_spr:-1,spr:spr_pistol_ammo_pack,name:get_txt("P_AMMO_BOX"),desc:get_txt("P_AMMO_BOX_DESC"),use_desc:get_txt("P_AMMO_BOX_USE"),type:ITEM_TYPE.CONSUMABLE,usable:true,onUse:function() {o_player.ammos[0]+=32} },
	pistol:{drop_spr:spr_gun_item,spr:spr_gun_0,name:get_txt("PISTOL"),desc:get_txt("PISTOL_DESC"),type:ITEM_TYPE.WEAPON,usable:false,weap:variable_clone(o_global_mngr.weapons_list.gun)},
	shotgun:{drop_spr:spr_gun_item_1,spr:spr_gun_1,name:get_txt("SHOTGUN"),desc:get_txt("SHOTGUN_DESC"),type:ITEM_TYPE.WEAPON,usable:false,weap:variable_clone(o_global_mngr.weapons_list.shotgun)},
	rifle:{drop_spr:spr_gun_item_2,spr:spr_gun_2,name:get_txt("RIFLE"),desc:get_txt("RIFLE_DESC"),type:ITEM_TYPE.WEAPON,usable:false,weap:variable_clone(o_global_mngr.weapons_list.rifle)},
	bat:{drop_spr:spr_gun_item_3,spr:spr_gun_3,name:get_txt("BAT"),desc:get_txt("BAT_DESC"),type:ITEM_TYPE.WEAPON,usable:false,weap:variable_clone(o_global_mngr.weapons_list.bat)},
	shirt:{drop_spr:spr_shirt_0_item,spr:spr_shirt_0,name:get_txt("SHIRT_0"),desc:get_txt("SHIRT_0_DESC"),type:ITEM_TYPE.CHESTGEAR,usable:false,replace_spr:spr_player_body_shirt_0,spd:0.1},
	hat:{drop_spr:spr_hat_0_item,spr:spr_hat_0,name:get_txt("HAT_0"),desc:get_txt("HAT_0_DESC"),type:ITEM_TYPE.HEADGEAR,usable:false,replace_spr:spr_player_head_hat_0,spd:0.1 },
	milit_shirt:{drop_spr:spr_shirt_1_item, spr:spr_shirt_1,name:get_txt("SHIRT_1"),desc:get_txt("SHIRT_1_DESC"),type:ITEM_TYPE.CHESTGEAR,usable:false,replace_spr:spr_player_body_shirt_1}
}

//weapon buffs
w_buffs={
	reload_speed:0,
	damage:0,
	pierce:0,
	proj_spd:0,
	accuracy:0,
	proj_multi:0,
	ammo_multi:0,
	firerate:0,
	weight_reduction:0,
}


weapons=[-1,-1,-1 ]

frame=0
frame_time=0

interact_id=-1
interact_spr=-1

weap_state=WSTATES.IDLE
curr_weap=1
burst_time=0
burst_num=0

camx=x
camy=y

regen_cdwn=0
regen_cdwn_max=60
regen_amnt=0

camsize=[320/2,180/2]
global.shake=[]
global.shake_time=[]

camera_set_view_pos(view_camera[0],x-camsize[0],y-camsize[1])



brightness=shader_get_uniform(sh_brightness,"powr")  
brightness_power=0 

depth=-y

function proj_create(xx,yy,dir,proj)
{
var tags_={}
var stat_eff=-1
var spd_=array_stat( proj.spd ) * (1+w_buffs.proj_spd)
var dmg_=array_stat( proj.dmg ) *(1+ w_buffs.damage)
var hits_=array_stat( proj.hits ) * (1+w_buffs.pierce)
var spr_=get_spr(proj.spr)
var w_power=proj.bullet_power
var vis=1
var lifetime_=5000

if variable_struct_exists(proj,"invisible")
{
if proj.invisible==true
vis=0
}

if variable_struct_exists(proj,"lifetime")
lifetime_=proj.lifetime

if variable_struct_exists(proj,"status_effects")
var stat_eff=proj.status_effects

if variable_struct_exists(proj,"tags")
var tags_=variable_clone(proj.tags)

if variable_struct_exists(proj,"spread")
{
dir+=array_stat(proj.spread)*(1-w_buffs.accuracy)
}

with instance_create_depth(xx,yy,depth+50,o_proj_parent){
sprite_index=spr_
image_angle=dir
direction=image_angle
dmg=dmg_
dmg_max=dmg_
hits=hits_
status_effects=stat_eff
pow=w_power
tags=tags_
speed=spd_
visible=vis
alarm[0]=lifetime_
var id_=id
}

with instance_create_depth(x,y,-1,o_follow_light) { follow_obj=id_ image_xscale=0.25 image_yscale=image_xscale }

}

brightness=shader_get_uniform(sh_brightness,"powr")  
brightness_power=0

eq_alpha=0

eq_state=EQUIPMENT_MENUS.INVENTORY

inventory={
posx:[],
posy:[],
type:[],
item:[],
}

inv_slot_add(0,0,SLOT_TYPE.NORMAL,-1)
inv_slot_add(0,80,SLOT_TYPE.NORMAL,-1)
inv_slot_add(0,160,SLOT_TYPE.NORMAL,-1)
inv_slot_add(0,240,SLOT_TYPE.NORMAL,-1)

inv_slot_add(80,0,SLOT_TYPE.NORMAL,variable_clone(items_list.shirt))
inv_slot_add(80,80,SLOT_TYPE.NORMAL,variable_clone(items_list.bat))
inv_slot_add(80,160,SLOT_TYPE.NORMAL,variable_clone(items_list.rifle))
inv_slot_add(80,240,SLOT_TYPE.NORMAL,variable_clone(items_list.shotgun))

inv_slot_add(160,0,SLOT_TYPE.NORMAL,variable_clone(items_list.pistol_ammo_box))
inv_slot_add(160,80,SLOT_TYPE.NORMAL,variable_clone(items_list.hat))
inv_slot_add(160,160,SLOT_TYPE.NORMAL,-1)
inv_slot_add(160,240,SLOT_TYPE.NORMAL,-1)

inv_slot_add(260,0,SLOT_TYPE.HEADGEAR,-1)
inv_slot_add(260,80,SLOT_TYPE.CHESTGEAR,variable_clone(items_list.milit_shirt))
inv_slot_add(260,160,SLOT_TYPE.LEGSGEAR,-1)
inv_slot_add(260,240,SLOT_TYPE.FEETSGEAR,-1)

inv_slot_add(340,0,SLOT_TYPE.WEAPON,variable_clone(items_list.pistol))
inv_slot_add(340,80,SLOT_TYPE.WEAPON_1,-1)
inv_slot_add(340,160,SLOT_TYPE.WEAPON_2,-1)

inv_slot_add(0,320,SLOT_TYPE.THRASH,-1)

holding_item=-1

function check_free_slots()
{
var ret=undefined

for(var i=0;i<array_length(inventory.posx);i++)
	{
if inventory.item[i]==-1
{

ret=i
break

}
	}
return ret

}

function item_get_stats(item_struct){
if variable_struct_exists(item_struct,"reg_amnt")
regen_amnt+=item_struct.reg_amnt
if variable_struct_exists(item_struct,"reg_spd")
regen_cdwn_max-=regen_cdwn_max*item_struct.reg_spd
if variable_struct_exists(item_struct,"mlife")
max_life+=item_struct.mlife
if variable_struct_exists(item_struct,"spd")
spd_buff+=item_struct.spd
if variable_struct_exists(item_struct,"def")
defense+=item_struct.def
if variable_struct_exists(item_struct,"rel_spd")
w_buffs.reload_speed+=item_struct.rel_spd
if variable_struct_exists(item_struct,"dmg")
w_buffs.damage+=item_struct.dmg
if variable_struct_exists(item_struct,"hit")
w_buffs.pierce+=item_struct.hit
if variable_struct_exists(item_struct,"pro_spd")
w_buffs.proj_spd+=item_struct.pro_spd
if variable_struct_exists(item_struct,"acc")
w_buffs.accuracy+=item_struct.acc
if variable_struct_exists(item_struct,"pro_amt")
w_buffs.proj_multi+=item_struct.pro_amt
if variable_struct_exists(item_struct,"am_mul")
w_buffs.ammo_multi+=item_struct.am_mul
if variable_struct_exists(item_struct,"frt")
w_buffs.firerate+=item_struct.frt
if variable_struct_exists(item_struct,"we_red")
w_buffs.weight_reduction+=item_struct.we_red
}

function inventory_equipment_update()
{
spd_buff=0
defense=0
max_life=20
regen_amnt=0
regen_cdwn_max=60

w_buffs={
	reload_speed:0,
	damage:0,
	pierce:0,
	proj_spd:0,
	accuracy:0,
	proj_multi:0,
	ammo_multi:0,
	firerate:0,
	weight_reduction:0,
}

for(var i=0;i<array_length(inventory.posx);i++)
	{
	switch(inventory.type[i])
		{
		case SLOT_TYPE.WEAPON: 
		if inventory.item[i]!=-1 
		weapons[0]=inventory.item[i].weap
		else 
		weapons[0]=-1 
		break;
		case SLOT_TYPE.WEAPON_1: 
		if inventory.item[i]!=-1
		weapons[1]=inventory.item[i].weap
		else 
		weapons[1]=-1 break;
		case SLOT_TYPE.WEAPON_2: 
		if inventory.item[i]!=-1
		weapons[2]=inventory.item[i].weap
		else weapons[2]=-1
		break;
		case SLOT_TYPE.HEADGEAR: 
		if inventory.item[i]!=-1 
		{
		item_get_stats(inventory.item[i])
		head_spr=inventory.item[i].replace_spr
		}
		else 
		head_spr=spr_player_head 
		break;
		case SLOT_TYPE.CHESTGEAR:
		if inventory.item[i]!=-1 
		{
		item_get_stats(inventory.item[i])
		body_spr=inventory.item[i].replace_spr 
		}
		else 
		body_spr=spr_player_body_empty
		break;
		case SLOT_TYPE.LEGSGEAR:
		if inventory.item[i]!=-1 
		{
		item_get_stats(inventory.item[i])
		}
		break;
		case SLOT_TYPE.FEETSGEAR:
		if inventory.item[i]!=-1 
		{
		item_get_stats(inventory.item[i])
		}
		break;
		}
	}
	
}

head_spr=spr_player_head
body_spr=spr_player_body_empty

inventory_equipment_update()

last_mouse_pos=[-1,-1]
last_mouse_dir=-1

life=20
life_fake=life
max_life=life


gui_info=[-1,"",-1] //info like cannot equip on this slot
info_line=[]

dmg_list=ds_list_create()

life_lerp=life
gui_alpha=1

enum DIAL_SPR{
WALKIE_TALKIE,
PLAYER_FACE
}

indialog=true
dialog={
txts:["Welcome in this place","What do you mean ? Are you crazy"],
spr:[DIAL_SPR.WALKIE_TALKIE,DIAL_SPR.PLAYER_FACE],
action:[],
dial_num:0,
dial_pos:0,
can_move:false,
box_size:0,
pos:0,
last_spr: DIAL_SPR.WALKIE_TALKIE,
last_txt: ""
}