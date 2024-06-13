//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 frag = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	frag.r = 1.;
	frag.g = 1.;
	frag.b = 1.;
	frag.a = .8;
    gl_FragColor = frag;
}
