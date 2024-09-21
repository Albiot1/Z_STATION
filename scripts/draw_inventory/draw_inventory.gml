/// @function draw_inventory(pos_x, pos_y, inv_str)
/// @arg pos_x
/// @arg pos_y
/// @arg inv_str
function draw_inventory(pos_x,pos_y,inv_str){
var mx=device_mouse_x_to_gui(0)
var my=device_mouse_y_to_gui(0)
var return_item=-1
var return_pos=[-1,-1]
var on_gui=0
for(var i=0;i<array_length(inv_str.posx);i++)
		{
	var px=pos_x+inv_str.posx[i]
	var py=pos_y+inv_str.posy[i]
	var tp=inv_str.type[i]
	var it=inv_str.item[i]
	var it_type=-1
	if o_player.holding_item!=-1
	it_type=o_player.holding_item.type
	
	if point_in_rectangle(mx,my,px,py,px+64,py+64)
	{
	on_gui=1
	}
	
	if tp==0
	draw_sprite_ext(spr_eq_slot,0,px,py,2,2,0,c_white,1)
	else
	{
	
	if it!=-1 and tp!=SLOT_TYPE.THRASH
	draw_sprite_ext(spr_eq_slot,0,px,py,2,2,0,c_white,1)
	else
	draw_sprite_ext(spr_eq_spec_slots,tp,px,py,2,2,0,c_white,1)

	}
	
	if it!=-1
	{
		
	draw_sprite_ext(it.spr,0,px,py,2,2,0,c_white,1)
	if point_in_rectangle(mx,my,px,py,px+64,py+64)
		{
		return_item=it
		return_pos[0]=px
		return_pos[1]=py

	if mouse_check_button_pressed(mb_left) and o_player.holding_item==-1
	{
	var check=0
	if it.type==ITEM_TYPE.CHESTGEAR or it.type==ITEM_TYPE.FEETSGEAR or it.type==ITEM_TYPE.HEADGEAR or it.type==ITEM_TYPE.LEGSGEAR or it.type==ITEM_TYPE.WEAPON
	check=1
	
	
	o_player.holding_item=inv_str.item[i]
	inv_str.item[i]=-1
	it=-1
	audio_play_sound(snd_invpickup,0,0)
	
	if check==1
	{
	inventory_equipment_update()
	}
	}
	else if mouse_check_button_pressed(mb_left) and o_player.holding_item!=-1
	{
	var can_do=0
	
	if (tp==SLOT_TYPE.NORMAL or tp==SLOT_TYPE.THRASH)
	can_do=1
	else if (tp==SLOT_TYPE.WEAPON or tp==SLOT_TYPE.WEAPON_1 or tp==SLOT_TYPE.WEAPON_2)
	{
		if it_type==ITEM_TYPE.WEAPON
		can_do=1
		else
		can_do=0
	}
	else if tp==SLOT_TYPE.CHESTGEAR
	{
		if it_type==ITEM_TYPE.CHESTGEAR
		can_do=1
		else
		can_do=0
	}
	else if tp==SLOT_TYPE.HEADGEAR
	{
		if it_type==ITEM_TYPE.HEADGEAR
		can_do=1
		else
		can_do=0
	}
	else if tp==SLOT_TYPE.FEETSGEAR
	{
		if it_type==ITEM_TYPE.FEETSGEAR
		can_do=1
		else 
		can_do=0
	}
	else if tp==SLOT_TYPE.LEGSGEAR
	{
		if it_type==ITEM_TYPE.LEGSGEAR
		can_do=1
		else
		can_do=0
	}
	
	if can_do==1
		{
	audio_play_sound(snd_invpickup,0,0)
	var o_it=inv_str.item[i]
	inv_str.item[i]=o_player.holding_item
	o_player.holding_item=o_it
	inventory_equipment_update()
		}
		else
		{
	o_player.gui_info=[120,"cannot equip on this slot",120]
	audio_play_sound(snd_cannotequip,0,0)
		}
	}
		
	if it!=-1
	if it.type==ITEM_TYPE.CONSUMABLE
	{
	if mouse_check_button_pressed(mb_right)
		{
	add_alert("USED: "+it.name,100)
	it.onUse()
	instance_create_depth(px,py,-1,o_used_effect)
	if it.usable==true
	inv_str.item[i]=-1
		}
	}
	if tp==SLOT_TYPE.THRASH
	{
	with instance_create_depth(px,py,-1,o_used_effect) {sprite_index=spr_item_deleted}
	inv_str.item[i]=-1
	}

		}
		
	}
	else
{
	if point_in_rectangle(mx,my,px,py,px+64,py+64)
		{
	if mouse_check_button_pressed(mb_left) and o_player.holding_item!=-1
	{
	var can_do=0
	
	if (tp==SLOT_TYPE.NORMAL or tp==SLOT_TYPE.THRASH)
	can_do=1
	else if (tp==SLOT_TYPE.WEAPON or tp==SLOT_TYPE.WEAPON_1 or tp==SLOT_TYPE.WEAPON_2)
	{
		if it_type==ITEM_TYPE.WEAPON
		can_do=1
		else
		can_do=0
	}
	else if tp==SLOT_TYPE.CHESTGEAR
	{
		if it_type==ITEM_TYPE.CHESTGEAR
		can_do=1
		else
		can_do=0
	}
	else if tp==SLOT_TYPE.HEADGEAR
	{
		if it_type==ITEM_TYPE.HEADGEAR
		can_do=1
		else
		can_do=0
	}
	else if tp==SLOT_TYPE.FEETSGEAR
	{
		if it_type==ITEM_TYPE.FEETSGEAR
		can_do=1
		else 
		can_do=0
	}
	else if tp==SLOT_TYPE.LEGSGEAR
	{
		if it_type==ITEM_TYPE.LEGSGEAR
		can_do=1
		else
		can_do=0
	}

	if can_do==1
		{
	inv_str.item[i]=o_player.holding_item
	o_player.holding_item=-1
	inventory_equipment_update()
	audio_play_sound(snd_invputdown,0,0)
		}
		else
		{
	o_player.gui_info=[120,"cannot equip on this slot",120]		
	audio_play_sound(snd_cannotequip,0,0)
		}
		
	}
		}
	
}
	
		}

if return_item!=-1
	{
//var s_w=string_width(return_item.name)
var s_w=300
var s_h=string_height_ext(return_item.desc,12,s_w)
return_pos[0]+=32
	draw_set_alpha(0.5) draw_set_color(c_gray)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1]+64,return_pos[0]+s_w/2+5,return_pos[1]+64+16,0)
	draw_set_alpha(1) draw_set_color(c_white)
	draw_set_halign(fa_center)
	draw_text(return_pos[0],return_pos[1]+64,return_item.name)
	draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1]+64+16,return_pos[0]+s_w/2+5,return_pos[1]+64+16+s_h,0)
	draw_set_alpha(1) draw_set_color(c_white)
	draw_text_ext(return_pos[0],return_pos[1]+64+16,return_item.desc,12,s_w)


switch(return_item.type)
{
case ITEM_TYPE.CONSUMABLE:
	draw_set_alpha(0.5) draw_set_color(c_gray)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1]+64+16+s_h,return_pos[0]+s_w/2+5,return_pos[1]+64+16+s_h+16,0)
	draw_set_alpha(1) draw_set_color(c_white)
draw_text(return_pos[0],return_pos[1]+64+16+s_h,"PRESS |RMB| TO USE")
var consumable_s_h=string_height_ext(return_item.use_desc,12,s_w)
	draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1]+64+16+s_h+16,return_pos[0]+s_w/2+5,return_pos[1]+64+16+s_h+16+consumable_s_h,0)
	draw_set_alpha(1) draw_set_color(c_white)
draw_text_ext(return_pos[0],return_pos[1]+64+16+s_h+16,return_item.use_desc,12,s_w)
break;
case ITEM_TYPE.COLLECTABLE: break;
default:

return_pos[1]+=s_h
	draw_set_alpha(0.5) draw_set_color(c_gray)
return_pos[1]+=80
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
	draw_set_alpha(1) draw_set_color(c_white)
draw_text(return_pos[0],return_pos[1],"-------------")

if variable_struct_exists(return_item,"spd")
{
var txt_name=get_txt("ARMOR_STAT_0")
var stat=return_item.spd
return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)
if stat>0
{
draw_text(return_pos[0],return_pos[1],txt_name+": +")
draw_set_halign(fa_left)
draw_text_color(return_pos[0]+string_width(txt_name+": +")/2,return_pos[1],stat,c_green,c_green,c_green,c_green,1)
draw_set_halign(fa_center)
}
else
{
draw_text(return_pos[0],return_pos[1],txt_name+": -")
draw_set_halign(fa_left)
draw_text_color(return_pos[0]+string_width(txt_name+": -")/2,return_pos[1],stat,c_green,c_green,c_green,c_green,1)
draw_set_halign(fa_center)
}
}

if variable_struct_exists(return_item,"def")
{
var txt_name=get_txt("ARMOR_STAT_1")
var stat=return_item.def
return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)
if stat>0
{
draw_text(return_pos[0],return_pos[1],txt_name+": +")
draw_set_halign(fa_left)
draw_text_color(return_pos[0]+string_width(txt_name+": +")/2,return_pos[1],stat,c_green,c_green,c_green,c_green,1)
draw_set_halign(fa_center)
}
else
{
draw_text(return_pos[0],return_pos[1],txt_name+": -")
draw_set_halign(fa_left)
draw_text_color(return_pos[0]+string_width(txt_name+": -")/2,return_pos[1],stat,c_green,c_green,c_green,c_green,1)
draw_set_halign(fa_center)
}
}

if variable_struct_exists(return_item,"rel_spd")
{
var txt_name=get_txt("ARMOR_STAT_2")
var stat=return_item.rel_spd
return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)
if stat>0
{
draw_text(return_pos[0],return_pos[1],txt_name+": +") draw_text_color(return_pos[0]+string_width(txt_name+": +"),return_pos[1],string(stat)+"%",c_green,c_green,c_green,c_green,1)
}
else
{
draw_text(return_pos[0],return_pos[1],txt_name+": -") draw_text_color(return_pos[0]+string_width(txt_name+": -"),return_pos[1],string(stat)+"%",c_red,c_red,c_red,c_red,1)
}
}

if variable_struct_exists(return_item,"dmg")
{
var txt_name=get_txt("ARMOR_STAT_3")
var stat=return_item.dmg
return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)
if stat>0
{
draw_text(return_pos[0],return_pos[1],txt_name+": +") draw_text_color(return_pos[0]+string_width(txt_name+": +"),return_pos[1],string(stat)+"%",c_green,c_green,c_green,c_green,1)
}
else
{
draw_text(return_pos[0],return_pos[1],txt_name+": -") draw_text_color(return_pos[0]+string_width(txt_name+": -"),return_pos[1],string(stat)+"%",c_red,c_red,c_red,c_red,1)
}
}

if variable_struct_exists(return_item,"hit")
{
var txt_name=get_txt("ARMOR_STAT_4")
var stat=return_item.hit
return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)
if stat>0
{
draw_text(return_pos[0],return_pos[1],txt_name+": +") draw_text_color(return_pos[0]+string_width(txt_name+": +"),return_pos[1],string(stat)+"%",c_green,c_green,c_green,c_green,1)
}
else
{
draw_text(return_pos[0],return_pos[1],txt_name+": -") draw_text_color(return_pos[0]+string_width(txt_name+": -"),return_pos[1],string(stat)+"%",c_red,c_red,c_red,c_red,1)
}
}

if variable_struct_exists(return_item,"pro_spd")
{
var txt_name=get_txt("ARMOR_STAT_5")
var stat=return_item.pro_spd
return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)
if stat>0
{
draw_text(return_pos[0],return_pos[1],txt_name+": +") draw_text_color(return_pos[0]+string_width(txt_name+": +"),return_pos[1],string(stat)+"%",c_green,c_green,c_green,c_green,1)
}
else
{
draw_text(return_pos[0],return_pos[1],txt_name+": -") draw_text_color(return_pos[0]+string_width(txt_name+": -"),return_pos[1],string(stat)+"%",c_red,c_red,c_red,c_red,1)
}
}

if variable_struct_exists(return_item,"acc")
{
var txt_name=get_txt("ARMOR_STAT_6")
var stat=return_item.acc
return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)
if stat>0
{
draw_text(return_pos[0],return_pos[1],txt_name+": +") draw_text_color(return_pos[0]+string_width(txt_name+": +"),return_pos[1],string(stat)+"%",c_green,c_green,c_green,c_green,1)
}
else
{
draw_text(return_pos[0],return_pos[1],txt_name+": -") draw_text_color(return_pos[0]+string_width(txt_name+": -"),return_pos[1],string(stat)+"%",c_red,c_red,c_red,c_red,1)
}
}

if variable_struct_exists(return_item,"pro_amt")
{
var txt_name=get_txt("ARMOR_STAT_7")
var stat=return_item.pro_amt
return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)
if stat>0
{
draw_text(return_pos[0],return_pos[1],txt_name+": +") draw_text_color(return_pos[0]+string_width(txt_name+": +"),return_pos[1],string(stat)+"%",c_green,c_green,c_green,c_green,1)
}
else
{
draw_text(return_pos[0],return_pos[1],txt_name+": -") draw_text_color(return_pos[0]+string_width(txt_name+": -"),return_pos[1],string(stat)+"%",c_red,c_red,c_red,c_red,1)
}
}

if variable_struct_exists(return_item,"am_mul")
{
var txt_name=get_txt("ARMOR_STAT_8")
var stat=return_item.am_mul
return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)
if stat>0
{
draw_text(return_pos[0],return_pos[1],txt_name+": +") draw_text_color(return_pos[0]+string_width(txt_name+": +"),return_pos[1],string(stat)+"%",c_green,c_green,c_green,c_green,1)
}
else
{
draw_text(return_pos[0],return_pos[1],txt_name+": -") draw_text_color(return_pos[0]+string_width(txt_name+": -"),return_pos[1],string(stat)+"%",c_red,c_red,c_red,c_red,1)
}
}

if variable_struct_exists(return_item,"frt")
{
var txt_name=get_txt("ARMOR_STAT_9")
var stat=return_item.frt
return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)
if stat>0
{
draw_text(return_pos[0],return_pos[1],txt_name+": +") draw_text_color(return_pos[0]+string_width(txt_name+": +"),return_pos[1],string(stat)+"%",c_green,c_green,c_green,c_green,1)
}
else
{
draw_text(return_pos[0],return_pos[1],txt_name+": -") draw_text_color(return_pos[0]+string_width(txt_name+": -"),return_pos[1],string(stat)+"%",c_red,c_red,c_red,c_red,1)
}
}

if variable_struct_exists(return_item,"we_red")
{
var txt_name=get_txt("ARMOR_STAT_10")
var stat=return_item.we_red
return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)
if stat>0
{
draw_text(return_pos[0],return_pos[1],txt_name+": +") draw_text_color(return_pos[0]+string_width(txt_name+": +"),return_pos[1],string(stat)+"%",c_green,c_green,c_green,c_green,1)
}
else
{
draw_text(return_pos[0],return_pos[1],txt_name+": -") draw_text_color(return_pos[0]+string_width(txt_name+": -"),return_pos[1],string(stat)+"%",c_red,c_red,c_red,c_red,1)
}
}

if variable_struct_exists(return_item,"reg_speed")
{
var txt_name=get_txt("ARMOR_STAT_11")
var stat=return_item.we_red
return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)
if stat>0
{
draw_text(return_pos[0],return_pos[1],txt_name+": +") draw_text_color(return_pos[0]+string_width(txt_name+": +"),return_pos[1],string(stat)+"%",c_green,c_green,c_green,c_green,1)
}
else
{
draw_text(return_pos[0],return_pos[1],txt_name+": -") draw_text_color(return_pos[0]+string_width(txt_name+": -"),return_pos[1],string(stat)+"%",c_red,c_red,c_red,c_red,1)
}
}

if variable_struct_exists(return_item,"mlife")
{
var txt_name=get_txt("ARMOR_STAT_12")
var stat=return_item.we_red
return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)
if stat>0
{
draw_text(return_pos[0],return_pos[1],txt_name+": +") draw_text_color(return_pos[0]+string_width(txt_name+": +"),return_pos[1],string(stat)+"%",c_green,c_green,c_green,c_green,1)
}
else
{
draw_text(return_pos[0],return_pos[1],txt_name+": -") draw_text_color(return_pos[0]+string_width(txt_name+": -"),return_pos[1],string(stat)+"%",c_red,c_red,c_red,c_red,1)
}
}

if variable_struct_exists(return_item,"reg_amnt")
{
var txt_name=get_txt("ARMOR_STAT_13")
var stat=return_item.we_red
return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)
if stat>0
{
draw_text(return_pos[0],return_pos[1],txt_name+": +") draw_text_color(return_pos[0]+string_width(txt_name+": +"),return_pos[1],string(stat)+"%",c_green,c_green,c_green,c_green,1)
}
else
{
draw_text(return_pos[0],return_pos[1],txt_name+": -") draw_text_color(return_pos[0]+string_width(txt_name+": -"),return_pos[1],string(stat)+"%",c_red,c_red,c_red,c_red,1)
}
}


break;
case ITEM_TYPE.WEAPON: 

return_pos[1]+=s_h
	draw_set_alpha(0.5) draw_set_color(c_gray)
return_pos[1]+=80
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
	draw_set_alpha(1) draw_set_color(c_white)
draw_text(return_pos[0],return_pos[1],"-------------")


var txt_name=get_txt("WEAPON_STAT_0")
var stat=-1

var low_dmg=9999
for(var c=0;c<array_length(return_item.weap.projectiles);c++)
{
if low_dmg>array_frst(return_item.weap.projectiles[c].dmg)
low_dmg=array_frst(return_item.weap.projectiles[c].dmg)
}

var high_dmg=0
for(var c=0;c<array_length(return_item.weap.projectiles);c++)
{
if high_dmg<array_second(return_item.weap.projectiles[c].dmg)
high_dmg=array_second(return_item.weap.projectiles[c].dmg)
}

if low_dmg==high_dmg
stat=low_dmg*(1+w_buffs.damage)
else
stat=string(low_dmg*(1+w_buffs.damage))+"-"+string(high_dmg*(1+w_buffs.damage))

return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)

draw_text(return_pos[0],return_pos[1],txt_name+":"+string(stat))

var txt_name=get_txt("WEAPON_STAT_1")
var stat=-1

var low_hit=9999
for(var c=0;c<array_length(return_item.weap.projectiles);c++)
{
if low_hit>array_frst(return_item.weap.projectiles[c].hits)
low_hit=array_frst(return_item.weap.projectiles[c].hits)
}
var high_hit=0
for(var c=0;c<array_length(return_item.weap.projectiles);c++)
{
if high_hit<array_second(return_item.weap.projectiles[c].hits)
high_hit=array_second(return_item.weap.projectiles[c].hits)
}

if low_hit==high_hit
stat=low_hit*(1+w_buffs.pierce)
else
stat=string(low_hit*(1+w_buffs.pierce))+"-"+string(high_hit*(1+w_buffs.pierce))

return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)

draw_text(return_pos[0],return_pos[1],txt_name+":"+string(stat))

if return_item.weap.weapon_type!=W_TYPE.MELEE
{
var txt_name=get_txt("WEAPON_STAT_2")
var stat=-1

var low_spd=9999
for(var c=0;c<array_length(return_item.weap.projectiles);c++)
{
if low_spd>array_frst(return_item.weap.projectiles[c].spd)
low_spd=array_frst(return_item.weap.projectiles[c].spd)
}
var high_spd=0
for(var c=0;c<array_length(return_item.weap.projectiles);c++)
{
if high_spd<array_second(return_item.weap.projectiles[c].spd)
high_spd=array_second(return_item.weap.projectiles[c].spd)
}

if low_spd==high_spd
stat=low_spd*(1+w_buffs.proj_spd)
else
stat=string(low_spd*(1+w_buffs.proj_spd))+"-"+string(high_spd*(1+w_buffs.proj_spd))

return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)

draw_text(return_pos[0],return_pos[1],txt_name+":"+string(stat))
}

if return_item.weap.weapon_type!=W_TYPE.MELEE
{
var txt_name=get_txt("WEAPON_STAT_3")
var stat=-1

stat=return_item.weap.show_spread[1]*(1-w_buffs.accuracy)

return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)

draw_text(return_pos[0],return_pos[1],txt_name+":"+string(stat))
}

if return_item.weap.weapon_type!=W_TYPE.MELEE
{
var txt_name=get_txt("WEAPON_STAT_4")
var stat=-1

stat=return_item.weap.ammo_max*(1+w_buffs.ammo_multi)

return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)

draw_text(return_pos[0],return_pos[1],txt_name+":"+string(stat))
}

if variable_struct_exists(return_item.weap,"reload_anim_time") and return_item.weap.weapon_type!=W_TYPE.MELEE
{
var txt_name=get_txt("WEAPON_STAT_5")
var stat=-1

stat=return_item.weap.reload_anim_time*(1-w_buffs.reload_speed)/60

return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)

draw_text(return_pos[0],return_pos[1],txt_name+":"+string(stat)+"s")
}

var txt_name=get_txt("WEAPON_STAT_6")
var stat=-1

stat=(return_item.weap.shot_anim_time*(1-w_buffs.firerate)+return_item.weap.firerate*(1-w_buffs.firerate))/60

return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)

draw_text(return_pos[0],return_pos[1],txt_name+":"+string(stat)+"s")

if variable_struct_exists(return_item.weap,"weight")
{
var txt_name=get_txt("WEAPON_STAT_7")
var stat=return_item.weap.weight*(1-w_buffs.weight_reduction)
return_pos[1]+=17
draw_set_alpha(0.5) draw_set_color(c_black)
draw_rectangle(return_pos[0]-s_w/2-5,return_pos[1],return_pos[0]+s_w/2+5,return_pos[1]+16,0)
draw_set_alpha(1) draw_set_color(c_white)
if stat>0
draw_text(return_pos[0],return_pos[1],txt_name+":"+string(stat))
}

break;
}

	draw_set_halign(fa_left)
	

	}

	if o_player.holding_item!=-1
		{
		draw_sprite_ext(o_player.holding_item.spr,0,mx,my,2,2,0,c_white,1)
		
		if on_gui==0 and mouse_check_button_pressed(mb_left)
		{
		with instance_create_depth(x,y,-1,o_item) {speed=2 direction=point_direction(o_player.x,o_player.y,mouse_x,mouse_y) your_item=o_player.holding_item cant_collect=60 sprite_index=your_item.drop_spr}
		o_player.holding_item=-1
		audio_play_sound(snd_drop,0,0)
		}
		
		}

}