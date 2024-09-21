if instance_place(x,y,o_wall)
speed=0

image_xscale=lerp(image_xscale,2,0.01)
image_yscale=image_xscale
image_alpha=lerp(image_alpha,0,0.1)
if image_alpha<=0.1
instance_destroy()

image_angle+=speed*10