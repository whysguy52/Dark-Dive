extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func reset_ping():
	material_override.set_shader_param("time", OS.get_ticks_msec() / 1000 - 1)
	#material_override.shader.code = generate_shader_code()

func generate_shader_code():
	return
#	return """shader_type spatial;
#render_mode unshaded;
#
#uniform vec4 color : hint_color = vec4( 0.54, 0.0, 0.0, 1.0);
#uniform float shift_dist = 0.0;
#uniform float speed = 80.0;
#uniform float interval = 400.0;
#uniform float residual = 50.0;
#const float time = %f;
#
#void fragment( )
#{
#	ALBEDO = color.rgb;
#	DEPTH = 0.0;
#
#	float depth = textureLod( DEPTH_TEXTURE, SCREEN_UV, 0.0 ).x;
#	vec4 pos = INV_PROJECTION_MATRIX * vec4( 0.0, 0.0, depth * 2.0 - 1.0, 1.0 );
#	float d = -pos.z / pos.w;
#	float dist = shift_dist + mod( (TIME - time) * speed, interval );
#	ALPHA = clamp(
#		float( ( dist - residual < d ) && ( d < dist ) ) * ( ( d - ( dist - residual ) ) / residual )
#	,	0.0
#	,	0.3
#	);
#}""" \
#			% [OS.get_ticks_msec() / 1000]
#
#
#func _on_PingTimer_timeout():
#	pass # Replace with function body.
