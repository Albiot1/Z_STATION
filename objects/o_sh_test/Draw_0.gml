/*
var replaceColor = [1.0, 0.0, 0.0, 1.0]; // Czerwony kolor, który chcemy zamienić
var newColor = [0.0, 1.0, 1.0, 1.0];     // Nowy zielony kolor

shader_set(sh_color_r1);
shader_set_uniform_f(shader_replace_color, replaceColor[0], replaceColor[1], replaceColor[2], replaceColor[3]);
shader_set_uniform_f(shader_new_color, newColor[0], newColor[1], newColor[2], newColor[3]);
draw_self()
shader_reset()
*/

// Ustawienie shader
shader_set(sh_color_replace);

// Ustawienie kolorów i tolerancji
var replace_color = c_white;  // Kolor do zamiany
var new_color = c_yellow;        // Nowy kolor
var tolerance = 0.4;          // Tolerancja (0.0 - 1.0)

// Przekazanie wartości do shadera
shader_set_uniform_f(shader_get_uniform(sh_color_replace, "u_replaceColor"), color_get_red(replace_color)/255, color_get_green(replace_color)/255, color_get_blue(replace_color)/255, 1.0);
shader_set_uniform_f(shader_get_uniform(sh_color_replace, "u_newColor"), color_get_red(new_color)/255, color_get_green(new_color)/255, color_get_blue(new_color)/255, 1.0);
shader_set_uniform_f(shader_get_uniform(sh_color_replace, "u_tolerance"), tolerance);

// Rysowanie sprite
draw_self();

draw_text(x,y,"SUSSY BAKA IS WHITE")

// Wyłączenie shader
shader_reset();