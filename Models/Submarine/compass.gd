extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_transform.basis.x = Vector3(1,0,0)
	global_transform.basis.y = Vector3(0,1,0)
	global_transform.basis.z = Vector3(0,0,1)
	global_transform.basis.orthonormalized()
	#print_debug(global_transform.basis.x)