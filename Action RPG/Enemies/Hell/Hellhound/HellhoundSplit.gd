extends AnimatedSprite

onready var MiniHound = preload("res://Enemies/Hell/Hellhound/MiniHound.tscn")

func _ready():
	connect("animation_finished", self, "_on_animation_finished")
	frame = 0;
	play("Animate");


func _on_HellhoundSplit_animation_finished():
	var miniHound = MiniHound.instance()
	get_parent().add_child(miniHound)
	miniHound.global_position = global_position
	queue_free();
