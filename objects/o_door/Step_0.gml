if interaction_time>=interaction_max_time and open==0
{

open=1
instance_destroy(wall_obj)
image_speed=1.5
audio_play_sound(sfx_movement_dooropen4,0,0,1,0,0.8)
interactable=false
if array_length(activate)>0
	{
	
for(var i=0;i<array_length(activate);i++)
{
activate[i].active=1	
}
	
	}
	
}