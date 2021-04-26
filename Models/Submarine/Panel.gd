extends Panel


var O2Levels
var EnLevels
var EtoOTimer
var EtoOBtn
var OtoETimer
var OtoEBtn

var redButtonIcon
var greenButtonIcon


# Called when the node enters the scene tree for the first time.
func _ready():
	O2Levels = get_node("O2Bar")
	EnLevels = get_node("EnergyBar")
	EtoOTimer = get_node("EtoOTick")
	EtoOBtn = get_node("EtoOBtn")
	OtoETimer = get_node("OtoETick")
	OtoEBtn = get_node("OtoEBtn")
	
	redButtonIcon = ResourceLoader.load("res://Models/Submarine/UI_Components/ConvertButton.png")
	greenButtonIcon = ResourceLoader.load("res://Models/Submarine/UI_Components/ConvertButton2.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#Oxygen to Energy button event handlers
func _on_OtoETick_timeout():
	EnLevels.value += 4
	O2Levels.value -= 6
func _on_OtoEBtn_pressed():
	if OtoETimer.is_stopped():
		OtoETimer.start()
		OtoEBtn.icon = greenButtonIcon
	else:
		OtoETimer.start()
		OtoEBtn.icon = redButtonIcon

#Energy to Oxygen button even handlers
func _on_EtoOTick_timeout():
	O2Levels.value += 4
	EnLevels.value -= 6

func _on_EtoOBtn_pressed():
	if EtoOTimer.is_stopped():
		EtoOTimer.start()
		EtoOBtn.icon = greenButtonIcon
	else:
		EtoOTimer.stop()
		EtoOBtn.icon = redButtonIcon

#bar timers
func _on_O2Tick_timeout():
	O2Levels.value -= 2

func _on_EnTick_timeout():
	EnLevels.value -= 1








