extends MeshInstance


var PingTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	PingTimer = get_node("PingTimer")


func reset_ping():
	material_override.set_shader_param("time", OS.get_ticks_msec() / 1000.0 - 0.5)
	PingTimer.start()
	
