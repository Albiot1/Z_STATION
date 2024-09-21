/// @function load_json(file)
/// @arg file
function load_json(file){

var buff=buffer_load(file)
if buff!=-1
return json_parse(buffer_read(buff,buffer_string))
else
return -1

buffer_delete(buff)

}