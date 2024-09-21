if instance_exists(follow_obj)
{
x=follow_obj.x+follow_x_plus
y=follow_obj.y+follow_y_plus
}
else
{
image_xscale=lerp(image_xscale,0,0.1)
image_yscale=image_xscale
}
