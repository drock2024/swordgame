extends Node2D

var first_on = true
var second_on = true

onready var platform_1 = $Platform1
onready var platform_2 = $Platform2
onready var timer = $PlatformTimer
onready var timer2 = $PlatformTimer2
onready var hitbox1 = $Hitbox
onready var hitbox2 = $Hitbox2

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start(2)

func _process(delta):
	print(timer.time_left)


func _on_Timer_timeout():
	timer.stop()
	if first_on && second_on:
		platform_1.hide()
		first_on = false
		hitbox1.set_collision_mask_bit(2, true)
		timer2.start(1)
	if !first_on && !second_on:
		platform_1.show()
		first_on = true
		hitbox1.set_collision_mask_bit(2, false)
		timer2.start(1)


func _on_PlatformTimer2_timeout():
	timer2.stop()
	if second_on && !first_on:
		platform_2.hide()
		second_on = false
		hitbox2.set_collision_mask_bit(2, true)
		timer.start(2)
	if first_on && !second_on:
		platform_2.show()
		second_on = true
		hitbox2.set_collision_mask_bit(2, false)
		timer.start(2)
