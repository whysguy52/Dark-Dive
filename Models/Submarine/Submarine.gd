extends KinematicBody

#objects
var propeller
var Ping
var ShipNod
var energyBar
var O2Bar
var spotLight

#primitives
var direction
var speed = 4000
var MOUSE_SENSITIVITY = 0.02
var isPowered = true

var isPingDone = true
# Called when the node enters the scene tree for the first time.
func _ready():
	propeller = get_node("ShipNod/Propeller")
	ShipNod = get_node("ShipNod")
	Ping = get_node("ShipNod/SonarPing")
	energyBar = get_node("Control/Panel/EnergyBar")
	O2Bar = get_node("Control/Panel/O2Bar")
	spotLight = get_node("ShipNod/Spot")
	
	direction = Vector3()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	check_user_input()

func _physics_process(delta):
	move(delta)

func check_user_input():
	
	if isPowered:
		check_movement()
		check_ping()
	check_mouse_release()
	check_if_dead()
	check_if_powered()

func move(delta):
	direction = direction.normalized() * speed * delta
	var velocity = move_and_slide(direction)
	if velocity.length() != 0:
		propeller.spin(velocity)

#mouse controls
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and isPowered:
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
		energyBar.value -= 10
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

func charge():
	energyBar.value += 5

func check_if_dead():
	if O2Bar.value == 0:
		get_tree().change_scene("res://Menus/TitleScreen.tscn")

func check_if_powered():
	if energyBar.value == 0:
		isPowered = false
		spotLight.visible = false
	elif isPowered == false && spotLight.visible == false:
		isPowered = true
		spotLight.visible = true
