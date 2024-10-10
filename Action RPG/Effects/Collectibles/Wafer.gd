extends Node2D

var color = "Green"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayerDetectionZone_body_entered(body):
	if color == "Green":
		PlayerStats.green_slime = true
	if color == "Blue":
		PlayerStats.blue_slime = true
	if color == "Red":
		PlayerStats.red_slime = true
	queue_free();
