extends Area

var ChargeTimer
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	ChargeTimer = get_node("ChargeTimer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Spatial_body_entered(body):
	player = body
	ChargeTimer.start()


func _on_Spatial_body_exited(_body):
	ChargeTimer.stop()
	player = null


func _on_ChargeTimer_timeout():
	if player != null:
		player.charge()
