/// @function get_txt(str)
/// @arg str
function get_txt(str) {
    if variable_struct_exists(global.language,str)
    return global.language[$ str]
    else 
    return "NOT FOUND:"+str
}