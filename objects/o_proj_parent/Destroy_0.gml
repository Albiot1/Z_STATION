if tags.dest_eff!=-1
{
if variable_struct_exists(tags.dest_eff,"spr")
var spr_=tags.dest_eff.spr
else 
var spr_=spr_bull_dest

switch(tags.dest_eff.obj)
	{
	case "o_proj_effect": var obj_=o_proj_effect break;	
	}

with instance_create_depth(x,y,-1,obj_)
	{
	sprite_index=spr_	
	}

}