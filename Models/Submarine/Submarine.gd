extends KinematicBody


var propeller
var Ping

var direction
var speed = 1000

var MOUSE_SENSITIVITY = 0.02
var ShipNod
var moveXForm

# Called when the node enters the scene tree for the first time.
func _ready():
	propeller = get_node("ShipNod/Propeller")
	ShipNod = get_node("ShipNod")
	Ping = get_node("ShipNod/SonarPing")
	direction = Vector3()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_user_input()
	get_node("ShipNod/SonarPing")

func _physics_process(delta):
	move(delta)

func check_user_input():
	
	var inputVect = Vector3()
	var movementVect = Vector3()
	
	var forward = ShipNod.global_transform.basis.z
	var right = ShipNod.global_transform.basis.x
	var up = ShipNod.global_transform.basis.y
	
	inputVect.z = -int(Input.is_action_pressed("ui_forward")) + int(Input.is_action_pressed("ui_backward"))
	movementVect = movementVect + inputVect.z * forward
	inputVect.x = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	movementVect = movementVect + inputVect.x * right
	inputVect.y = -int(Input.is_action_pressed("ui_up")) + int(Input.is_action_pressed("ui_down"))
	movementVect = movementVect + inputVect.y * up
	movementVect.normalized()
	direction = movementVect
	
	if Input.is_action_just_pressed("ui_action"):
		Ping.visible = true
	if Input.is_action_just_released("ui_action"):
		Ping.visible = false

func move(delta):
	direction = direction * speed * delta
	var velocity = move_and_slide(direction)
	if velocity.length() != 0:
		propeller.spin(velocity)

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		ShipNod.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

		var camera_rot = ShipNod.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		ShipNod.rotation_degrees = camera_rot

func redirect_vector_to_local(globalVector:Vector3):
	return globalVector
