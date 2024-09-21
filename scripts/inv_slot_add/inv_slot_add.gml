/// @function inv_slot_add(px, py, tp, it)
/// @arg px
/// @arg py
/// @arg tp
/// @arg it
function inv_slot_add(px,py,tp,it)
{
array_push(inventory.posx,px)
array_push(inventory.posy,py)
array_push(inventory.type,tp)
array_push(inventory.item,it)
}