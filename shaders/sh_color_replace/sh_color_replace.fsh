// Fragment Shader
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 u_replaceColor;  // Kolor do zamiany (RGBA)
uniform vec4 u_newColor;      // Nowy kolor (RGBA)
uniform float u_tolerance;    // Tolerancja porównania kolorów

void main()
{
    vec4 texColor = texture2D(gm_BaseTexture, v_vTexcoord);
    
    float distance = length(texColor.rgb - u_replaceColor.rgb);
    
    if (distance < u_tolerance)
    {
        gl_FragColor = vec4(u_newColor.rgb, texColor.a * u_newColor.a);
    }
    else
    {
        gl_FragColor = texColor;
    }
}