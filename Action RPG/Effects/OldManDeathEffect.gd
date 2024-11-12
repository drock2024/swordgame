extends AnimatedSprite

func _ready():
	connect("animation_finished", self, "_on_animation_finished")
	frame = 0;
	play();

func _on_animation_finished():
	PlayerStats.oldManDefeated = true;
	#get_parent().show_ladders();
	queue_free();
	#get_tree().change_scene("res://World/Levels/FOrest/CastleBackdrop.tscn")
