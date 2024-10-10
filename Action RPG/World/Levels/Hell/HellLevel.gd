extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.time_of_day = "day";
	PlayerStats.area = "Hell"
	Player.healable = true
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), 0)


func _process(delta):
	if Input.is_action_just_pressed("heal") and PlayerStats.health > 0:
		Player.healable = false;
		Player.use_health_dagger();
