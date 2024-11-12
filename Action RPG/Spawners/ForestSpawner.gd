extends Node2D

const Bat = preload("res://Enemies/Bat.tscn");
const Bunny = preload("res://Enemies/Bunny.tscn");

func _ready():
	$AnimationPlayer.set_speed_scale(1.5);
	$AnimationPlayer.play("Summon");

func spawn_enemy():
	if PlayerStats.time_of_day == "day":
		var batInstance = Bat.instance();
		add_child(batInstance);
		batInstance.global_position = global_position;
	else:
		var bunnyInstance = Bunny.instance();
		add_child(bunnyInstance);
		bunnyInstance.global_position = global_position;
