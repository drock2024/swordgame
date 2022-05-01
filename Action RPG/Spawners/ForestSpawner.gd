extends Node2D

const Bat = preload("res://Enemies/Bat.tscn");
const Bunny = preload("res://Enemies/Bunny.tscn");

func _ready():
	$AnimationPlayer.set_speed_scale(1.5);
	$AnimationPlayer.play("Summon");

func spawn_enemy():
	self_modulate.a = 0;
	if PlayerStats.time_of_day == "day":
		var batInstance = Bat.instance();
		self.add_child(batInstance);
	else:
		var bunnyInstance = Bunny.instance();
		self.add_child(bunnyInstance);
