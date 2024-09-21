var cweap=weapons[curr_weap]
var mx=device_mouse_x_to_gui(0)
var my=device_mouse_y_to_gui(0)

	draw_set_halign(fa_center)
var y_pos=650
var x_pos=1280/2-128
for(var i=0;i<3;i++)
{

draw_set_alpha(gui_alpha)

draw_sprite_ext(spr_weapon_inv,curr_weap==i,x_pos+96*i,y_pos,2,2,0,c_white,gui_alpha)
if weapons[i]!=-1
		{
if curr_weap==i
	{
var pos=1-(cweap.cdwn/cweap.firerate*(1-w_buffs.firerate))
//draw_sprite_ext(spr_weapon_inv,curr_weap==i,553+96*i,y_pos,2*pos,2*pos,0,c_black,weap_alpha-0.5)
if pos>0.01
draw_rectangle_color(x_pos+96*i+4,y_pos+34-8,x_pos+96*i+4+64*pos-4,y_pos+34+8,c_black,c_black,c_black,c_black,0)
	}

draw_sprite_ext(get_spr(weapons[i].gui_spr),0,x_pos+96*i,y_pos,2,2,0,c_white,gui_alpha)

if weapons[i].weapon_type!=W_TYPE.MELEE
{
draw_text(x_pos+96*i+34,y_pos,string(weapons[i].ammo)+"/"+string(weapons[i].ammo_max*(1+w_buffs.ammo_multi)))
}

		}
		
draw_set_alpha(1)

}
	draw_set_halign(0)

if weap_state==WSTATES.INTERACT
{

if instance_exists(interact_id) and interact_spr!=-1
	{
draw_set_font(fnt_pixel_gui_medium)
var c_str=interact_id.interaction_name
var bar_w=clamp(string_width(c_str)+6,256,512)
var x_pos=640-bar_w/2
var y_pos=592-96
var bar_h=42

draw_sprite_stretched(spr_interaction_bar,0,x_pos,y_pos,bar_w ,bar_h)
draw_sprite_stretched(spr_interaction_bar,1,x_pos,y_pos,bar_w*(interact_id.interaction_time/interact_id.interaction_max_time) ,bar_h)
 draw_set_halign(fa_center)
draw_text_transformed(x_pos+bar_w/2,y_pos+9,c_str,1,1,0)
draw_set_halign(0)
draw_set_font(fnt_pixel_gui_small)
	}
	
}

var hbar_x=1280/2-128
var hbar_y=592
var hbar_w=256
var hbar_h=48

draw_set_alpha(gui_alpha)
draw_sprite_stretched(spr_health_bar,0,hbar_x,hbar_y,hbar_w,hbar_h)
draw_sprite_stretched(spr_health_bar,2,hbar_x,hbar_y,hbar_w*(life_fake/max_life),hbar_h)
draw_sprite_stretched(spr_health_bar,1,hbar_x,hbar_y,hbar_w*(life/max_life),hbar_h)
draw_set_font(fnt_pixel_gui_medium) draw_set_halign(fa_center)
draw_text(hbar_x+hbar_w/2,hbar_y+9,string(life)+"/"+string(max_life))
draw_set_font(fnt_pixel_gui_small) draw_set_halign(0)

draw_sprite_ext(spr_eq_icons,0,8,720-80,2,2,0,c_white,1)
draw_set_halign(fa_center)
draw_text(8+32,720-55,"|TAB|")
draw_set_halign(0)
draw_set_alpha(1)

draw_set_color(c_black) draw_set_alpha(eq_alpha)
draw_rectangle(0,0,1280,768,0)
draw_set_color(c_white)
draw_set_alpha(1)

if weap_state==WSTATES.EQUIPMENT
{
eq_alpha=lerp(eq_alpha,0.4,0.05)	 //dark background

draw_set_alpha(1-eq_alpha) //fade out equipment tab
draw_sprite_ext(spr_eq_icons,0,8,720-80,2,2,0,c_white,1-eq_alpha)
draw_set_halign(fa_center)
draw_text(8+32,720-55,"|TAB|")

draw_sprite_stretched(spr_eq_icon_back,0,1280/2-96,64,192,64)

var _x=1280/2-96 var _y=64 //inventory
draw_sprite_ext(spr_eq_icons,0,_x,_y,2,2,0,c_white,1)
//draw_rectangle(_x,_y,_x+64,_y+64)
if point_in_rectangle(mx,my,_x,_y,_x+64,_y+64) and mouse_check_button_pressed(mb_left)
{
eq_state=EQUIPMENT_MENUS.INVENTORY	
}

var _x=1280/2-32 var _y=64 //bestiary
draw_sprite_ext(spr_eq_icons,2,_x,_y,2,2,0,c_white,1)
if point_in_rectangle(mx,my,_x,_y,_x+64,_y+64) and mouse_check_button_pressed(mb_left)
{
eq_state=EQUIPMENT_MENUS.BESTIARY	
}

var _x=1280/2+32 var _y=64 //settings
draw_sprite_ext(spr_eq_icons,1,_x,_y			,2,2,0,c_white,1)
if point_in_rectangle(mx,my,_x,_y,_x+64,_y+64) and mouse_check_button_pressed(mb_left)
{
eq_state=EQUIPMENT_MENUS.SETTINGS	
}

draw_sprite_ext(spr_eq_selection,0,1280/2-96+64*eq_state,64,2,2,0,c_white,1)

switch(eq_state)
	{
	case EQUIPMENT_MENUS.INVENTORY:

	draw_inventory(1280/2-181,180,inventory)
	break;
	}

draw_set_alpha(1)
draw_set_halign(fa_left)

}
else
{
eq_alpha=lerp(eq_alpha,0,0.05)	
}

if weap_state==WSTATES.EQUIPMENT or indialog==true
{
gui_alpha=lerp(gui_alpha,0.25,0.1)	
}
else
{
gui_alpha=lerp(gui_alpha,1,0.1)	
}

#region info/alerts
draw_set_font(fnt_pixel_gui_medium)

for(var i=array_length(info_line)-1;i>=0;i--)
{

draw_text_color(0,0+20*i,info_line[i,0],c_white,c_white,c_white,c_white,1*(info_line[i,1]/info_line[i,2]))	
info_line[i,1]--
if info_line[i,1]<=0
array_delete(info_line,i,1)

}

if gui_info[0]>0
{
draw_set_halign(fa_center)
draw_text_color(1280/2,128,gui_info[1],c_red,c_red,c_red,c_red,gui_info[0]/gui_info[2])
draw_set_halign(fa_left)
gui_info[0]--	
}

draw_set_font(fnt_pixel_gui_small) 
#endregion

if (indialog==true){
dialog.pos=lerp(dialog.pos,8,0.1)

var str_=dialog.txts[dialog.dial_num]
var str_now_=string_copy( str_,0,dialog.dial_pos )
var pos_max_=string_length(str_)
var skipped_=false
if dialog.box_size<1
dialog.box_size=lerp(dialog.box_size,1,0.1)

if dialog.dial_pos<=pos_max_ and dialog.pos>=2
{
dialog.dial_pos+=0.2
}

if dialog.dial_pos<pos_max_-1{
if keyboard_check_pressed(keys.dialog_skip){
	dialog.dial_pos=pos_max_
	skipped_=true
	}
}

if keyboard_check_pressed(keys.dialog_skip) and skipped_==false
{
if dialog.dial_num<array_length(dialog.txts)-1{
	dialog.dial_pos=0
	dialog.dial_num++
	dialog.box_size=0
	}
else{
	indialog=false
	dialog.last_spr=dialog.spr[dialog.dial_num]
	dialog.last_txt=str_now_
	}
}

draw_sprite_ext(spr_picture_box,dialog.spr[dialog.dial_num],81,64+dialog.pos,2*dialog.box_size,2*dialog.box_size,0,c_white,1)
draw_sprite_stretched(spr_dialog_box,0,162+4,0+dialog.pos,1118-4,128)

draw_set_font(fnt_pixel_gui_medium)
draw_text_ext(162+8,6+dialog.pos,str_now_,18,1112)

//draw_rectangle(170,6,170+( 1118-16  ),128-6,1 )

}
else {
	dialog.pos=lerp(dialog.pos,-256,0.1)
	if dialog.pos>-128{
	draw_sprite_ext(spr_picture_box,dialog.last_spr,81,64+dialog.pos,2*dialog.box_size,2*dialog.box_size,0,c_white,1)
	draw_sprite_stretched(spr_dialog_box,0,162+4,0+dialog.pos,1118-4,128)
	draw_set_font(fnt_pixel_gui_medium)
	draw_text_ext(162+8,6+dialog.pos,dialog.last_txt,18,1112)
	}
}