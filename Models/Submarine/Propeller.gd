extends MeshInstance


var isMoving


# Called when the node enters the scene tree for the first time.
func _ready():
	isMoving = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#

func spin(movement: Vector3):
	if movement.length() != 0 and movement.z <= 0:
		rotate(Vector3(0,0,1), -0.25)
	elif movement.length() != 0 and movement.z > 0:
		rotate(Vector3(0,0,1), 0.25)
		
