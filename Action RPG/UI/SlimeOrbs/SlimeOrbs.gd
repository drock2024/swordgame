extends Control


onready var blueEmpty = $BlueOrbEmpty
onready var blueFull = $BlueOrbFull
onready var redEmpty = $RedOrbEmpty
onready var redFull = $RedOrbFull
onready var greenEmpty = $GreenOrbEmpty
onready var greenFull = $GreenOrbFull

func _process(delta):
	if PlayerStats.blue_slime:
		blueFull.show()
	if PlayerStats.red_slime:
		redFull.show()
	if PlayerStats.green_slime:
		greenFull.show()
