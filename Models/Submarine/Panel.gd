extends Panel


var O2Levels
var EnLevels


# Called when the node enters the scene tree for the first time.
func _ready():
	O2Levels = get_node("O2Bar")
	EnLevels = get_node("EnergyBar")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_O2Tick_timeout():
	O2Levels.value -= 2


func _on_EnTick_timeout():
	EnLevels.value -= 1
