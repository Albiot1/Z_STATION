/// @function array_stat(val)
/// @arg val
function array_stat(val)
{
if is_array(val)
return random_range(val[0],val[1])
else 
return val
}

function array_frst(val)
{
if is_array(val)
return val[0]
else 
return val  
}

function array_second(val)
{
if is_array(val)
return val[1]
else 
return val  
}