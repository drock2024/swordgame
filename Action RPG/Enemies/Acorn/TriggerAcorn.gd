extends "res://Enemies/Acorn/Acorn.gd"

onready var spawner = preload("res://Spawners/ForestSpawner.tscn");

func _on_Stats_no_health():
	queue_free();
	var enemyDeathEffect = EnemyDeathEffect.instance();
	get_parent().add_child(enemyDeathEffect);
	var one = spawner.instance();
	var two = spawner.instance();
	var three = spawner.instance();
	var four = spawner.instance();
	var five = spawner.instance();
	var six = spawner.instance();
	get_parent().add_child(one);
	get_parent().add_child(two);
	get_parent().add_child(three);
	get_parent().add_child(four);
	get_parent().add_child(five);
	get_parent().add_child(six);
	one.global_position = global_position - Vector2(64, 0);
	two.global_position = global_position + Vector2(64, 0);
	three.global_position = global_position + Vector2(0, 64);
	four.global_position = global_position - Vector2(0, 64);
	five.global_position = global_position + Vector2(64, 64);
	six.global_position = global_position - Vector2(64, 64);
	enemyDeathEffect.global_position = global_position;
	PlayerStats.trigger_acorn_defeated = true;
