extends MeshInstance


var isMoving
var PropellerAudio
var audioIsPlaying = false


# Called when the node enters the scene tree for the first time.
func _ready():
	PropellerAudio = get_node("PropellerAudio")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#

func spin(movement: Vector3):
	if movement.length() != 0 and movement.z <= 0:
		
		rotate(Vector3(0,0,1), -0.25)
	elif movement.length() != 0 and movement.z > 0:
		rotate(Vector3(0,0,1), 0.25)
		
	if movement.length() != 0 and !PropellerAudio.playing:
		PropellerAudio.play()
	elif movement.length() == 0 and PropellerAudio.playing:
		PropellerAudio.stop()
