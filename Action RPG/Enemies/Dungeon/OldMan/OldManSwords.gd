extends Node2D

onready var SwordBullet = preload("res://Enemies/Dungeon/OldMan/SwordBullet.tscn");
onready var player = find_parent("DungeonBoss").get_child(4).find_node("Player")

var rotating = true
var sword_queue = 1

func _ready():
	$Timer.start(3)

func _process(delta):
	if rotating:
		rotate(0.01)


func _on_Timer_timeout():
	#rotating = false
	$Timer.stop()
	var swordbullet = SwordBullet.instance();
	if sword_queue == 1:
		get_parent().add_child(swordbullet)
		swordbullet.global_position = $YSort/Sword1.global_position
		swordbullet.dir = (player.global_position - $YSort/Sword1.global_position).normalized();
		$YSort/Sword1.queue_free()
	elif sword_queue == 2:
		get_parent().add_child(swordbullet)
		swordbullet.global_position = $YSort/Sword2.global_position
		swordbullet.dir = (player.global_position - $YSort/Sword2.global_position).normalized();
		$YSort/Sword2.queue_free()
	elif sword_queue == 3:
		get_parent().add_child(swordbullet)
		swordbullet.global_position = $YSort/Sword3.global_position
		swordbullet.dir = (player.global_position - $YSort/Sword3.global_position).normalized();
		$YSort/Sword3.queue_free()
	elif sword_queue == 4:
		get_parent().add_child(swordbullet)
		swordbullet.global_position = $YSort/Sword4.global_position
		swordbullet.dir = (player.global_position - $YSort/Sword4.global_position).normalized();
		$YSort/Sword4.queue_free()
	elif sword_queue == 5:
		get_parent().add_child(swordbullet)
		swordbullet.global_position = $YSort/Sword5.global_position
		swordbullet.dir = (player.global_position - $YSort/Sword5.global_position).normalized();
		$YSort/Sword5.queue_free()
	elif sword_queue == 6:
		get_parent().add_child(swordbullet)
		swordbullet.global_position = $YSort/Sword6.global_position
		swordbullet.dir = (player.global_position - $YSort/Sword6.global_position).normalized();
		$YSort/Sword6.queue_free()
	elif sword_queue == 7:
		get_parent().add_child(swordbullet)
		swordbullet.global_position = $YSort/Sword7.global_position
		swordbullet.dir = (player.global_position - $YSort/Sword7.global_position).normalized();
		$YSort/Sword7.queue_free()
	elif sword_queue == 8:
		get_parent().add_child(swordbullet)
		swordbullet.global_position = $YSort/Sword8.global_position
		swordbullet.dir = (player.global_position - $YSort/Sword8.global_position).normalized();
		$YSort/Sword8.queue_free()
	else:
		queue_free();
	swordbullet.speed  = 130
	sword_queue += 1
	$Timer.start(3)
	#rotating = true
