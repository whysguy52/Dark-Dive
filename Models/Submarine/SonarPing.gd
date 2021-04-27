extends MeshInstance


var PingTimer
var PingSound


# Called when the node enters the scene tree for the first time.
func _ready():
	PingTimer = get_node("PingTimer")
	PingSound = get_node("PingAudio")


func reset_ping():
	#I may want to pass delta into here instead of 0.8
	PingSound.play()
	material_override.set_shader_param("time", OS.get_ticks_msec() / 1000.0 - 0.8)
	PingTimer.start()
	
