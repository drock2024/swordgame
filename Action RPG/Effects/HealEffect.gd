extends AnimatedSprite

func _ready():
	connect("animation_finished", self, "_on_animation_finished")
	frame = 0;
	play("Animate");
	print("bruh")

func _on_animation_finished():
	queue_free();
	#Player.healable = true;
