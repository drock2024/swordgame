extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if PlayerStats.area == "Dungeon":
		volume_db = -1000


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PlayerStats.area == "Dungeon":
		volume_db = -1000
