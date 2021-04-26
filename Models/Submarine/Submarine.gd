extends KinematicBody


var propeller
var Ping
var ShipNod
var energyBar

var direction
var speed = 2000
var MOUSE_SENSITIVITY = 0.02

var isPingDone = true
# Called when the node enters the scene tree for the first time.
func _ready():
	propeller = get_node("ShipNod/Propeller")
	ShipNod = get_node("ShipNod")
	Ping = get_node("ShipNod/SonarPing")
	energyBar = get_node("Control/Panel/EnergyBar")
	direction = Vector3()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_user_input()

func _physics_process(delta):
	move(delta)

func check_user_input():
	
	check_movement()
	check_ping()
	check_mouse_release()

func move(delta):
	direction = direction.normalized() * speed * delta
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

func check_movement():
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

func check_ping():
	if Input.is_action_pressed("ui_action") && isPingDone == true:
		Ping.visible = true
		isPingDone = false
		Ping.reset_ping()
	else:
		pass

func check_mouse_release():
	if Input.is_action_just_pressed("ui_tab") && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif Input.is_action_just_pressed("ui_tab") && Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode((Input.MOUSE_MODE_CAPTURED))

func _on_PingTimer_timeout():
	Ping.visible = false
	isPingDone = true
	print_debug(Ping.visible)

func charge():
	energyBar.value += 5
