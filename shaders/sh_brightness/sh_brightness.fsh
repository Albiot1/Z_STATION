//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float powr;
void main()
{
	vec4 base_col =  v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	base_col.rgb = base_col.rgb + powr;
    gl_FragColor = vec4(base_col.rgb,base_col.a);
}
