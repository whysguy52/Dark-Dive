/*
	水中探査装置シェーダー by あるる（きのもと 結衣）
	Sonar Shader by Yui Kinomoto @arlez80

	MIT License
*/
shader_type spatial;
render_mode unshaded;

uniform vec4 color : hint_color = vec4( 0.54, 0.0, 0.0, 1.0);
uniform float shift_dist = 0.0;
uniform float speed = 80.0;
uniform float interval = 400.0;
uniform float residual = 50.0;
uniform float time = 0.0;

void fragment( )
{
	ALBEDO = color.rgb;
	DEPTH = 0.0;

	float depth = textureLod( DEPTH_TEXTURE, SCREEN_UV, 0.0 ).x;
	vec4 pos = INV_PROJECTION_MATRIX * vec4( 0.0, 0.0, depth * 2.0 - 1.0, 1.0 );
	float d = -pos.z / pos.w;
	float dist = shift_dist + mod( (TIME - time) * speed, interval );
	ALPHA = clamp(
		float( ( dist - residual < d ) && ( d < dist ) ) * ( ( d - ( dist - residual ) ) / residual )
	,	0.0
	,	0.3
	);
}
