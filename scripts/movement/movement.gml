/// @function movement(sped)
/// @arg sped
function movement(sped){
var key_left=keyboard_check(keys.left)
var key_right=keyboard_check(keys.right)
var key_up=keyboard_check(keys.up)
var key_down=keyboard_check(keys.down)
var can_move=true

if indialog==true and dialog.can_move==false
can_move=false

if weap_state!=WSTATES.EQUIPMENT and can_move
{
hsp += (key_right - key_left)*sped
vsp += (key_down - key_up)*sped
}



if place_meeting(x+hsp,y,o_wall)
{
    var yplus = 0;
    while (place_meeting(x+hsp,y-yplus,o_wall) && yplus <= abs(1*hsp)) yplus += 2;
    if place_meeting(x+hsp,y-yplus,o_wall)
    {
        while (!place_meeting(x+sign(hsp),y,o_wall)) x+=sign(hsp);
        hsp = 0;
    }
    else
    {
        y -= yplus
    }
}
x += hsp;
//Vertical collision
if (place_meeting(x,y+vsp,o_wall))
{
    while(!place_meeting(x,y+sign(vsp),o_wall))
    {
        y += sign(vsp);
    }
    vsp = 0;
}
y=y+vsp


if abs(hsp)>max_hsp+sliperness+additional_spd
hsp=(max_hsp+sliperness+additional_spd)*sign(hsp)

if abs(vsp)>max_vsp+sliperness+additional_spd
vsp=(max_vsp+sliperness+additional_spd)*sign(vsp)

hsp*=0.65+sliperness
vsp*=0.65+sliperness

if abs(hsp)>0 or abs(vsp)>0
{
	

move_frame+=0.2*mean(abs(vsp),abs(hsp))/mean(max_vsp,max_hsp)

}

if vsp>0 and hsp==0
legs_dir=270
else if vsp<0 and hsp==0
legs_dir=90
else if vsp==0 and hsp>0
legs_dir=0
else if vsp==0 and hsp<0
legs_dir=180
else if vsp>0 and hsp>0
legs_dir=315
else if vsp>0 and hsp<0
legs_dir=225
else if vsp<0 and hsp>0
legs_dir=45
else if vsp<0 and hsp<0
legs_dir=135

}