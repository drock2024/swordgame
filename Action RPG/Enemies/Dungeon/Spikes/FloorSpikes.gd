extends Node2D


onready var spike_sprite = $AnimatedSprite
onready var timer = $SpikesTimer
onready var hitbox = $Hitbox

var state_array = ["inactive", "activate", "active"]
var curr_state = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	spike_sprite.animation = "inactive"
	hitbox.set_collision_mask_bit(2, false)
	timer.start(1)


func _process(delta):
	spike_sprite.animation = state_array[curr_state]


func _on_SpikesTimer_timeout():
	if curr_state == 0:
		curr_state = 1
		hitbox.set_collision_mask_bit(2, true)
		timer.start(0.3)
	elif curr_state == 1:
		curr_state = 2
		timer.start(2)
	else:
		hitbox.set_collision_mask_bit(2, false)
		curr_state = 0
		timer.start(2)
