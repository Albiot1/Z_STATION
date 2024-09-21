/// @description Drawing with color overlay

	// Using draw_sprite_ext_color to draw a shadow
	var color_shadow = make_color_rgb(58,157,83);
	
	draw_sprite_ext_color( sprite_index, image_index, x, y + 70, image_xscale, image_yscale * -0.5, image_angle, image_alpha, color_shadow, 1);

	// Using draw_self_color to draw the house itself
	var color = c_yellow;
	var alpha = ( cos(current_time*0.002) * 0.5 + 0.5);
	
	draw_self_color( color, alpha);