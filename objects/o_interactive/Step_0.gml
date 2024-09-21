if interaction_time>=interaction_max_time
{

switch(action_type)
{
case "activate": 
if is_array(action_arg)
{
for(var i=0;i<array_length(action_arg);i++)
	{
	action_arg[i].active=true	
	}
}
else
action_arg.active=true
break;
default: show_message(action_arg)
}

if singleuse==true and used==false
{
used=true
instance_destroy()
}

}






