/// @function random_weighted_array(list)
/// @arg list
function random_weighted_array(list){
{
    var sum = 0;
    for (var i=0; i<array_length(list); i++) {
		if i>0
        sum += list[i];
		else
		sum += list[i]
    }
    var rnd = random(sum);
    for (var i=0; i<array_length(list); i++) {
		
		if i>0
			{
        if (rnd < list[i]) return i;
        rnd -= list[i];
			}
			else
			{
        if (rnd < list[i]) return i;
        rnd -= list[i];				
			}
    }
}
}