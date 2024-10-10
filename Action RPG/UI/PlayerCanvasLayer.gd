extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	if PlayerStats.area == "Dungeon":
		$SlimeOrbs.show()
		$OrbUI.hide()
