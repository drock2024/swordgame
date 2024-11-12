extends KinematicBody2D

var dir = Vector2(0, 0);
var target_distance = Vector2(0,0)
var origin_pos = Vector2(0,0)
var speed = 120;
var turnaround = false
var spine_chunks = 0

onready var SpinePiece = preload("res://Enemies/Hell/Serpent/SpinePiece.tscn")

func _ready():
	spine_chunks = target_distance / Vector2(32,32)
	$Timer.start(0.2)
	$Timer2.start(3)
	
func _physics_process(delta):
	print("Dir: ", dir)
	move_and_slide(dir * speed);
	if !turnaround:
		rotation = dir.angle();
	if global_position.distance_to(origin_pos) > target_distance:
		dir = -dir
		rotation = (-dir).angle();
		turnaround = true
		$Timer.stop()
	if turnaround && global_position.distance_to(origin_pos) < 12:
		queue_free()

func _on_Timer_timeout():
	#$Timer.stop()
	var spine_piece = SpinePiece.instance()
	get_parent().add_child(spine_piece)
	spine_piece.global_position = global_position
	spine_piece.rotation = dir.angle()
	


func _on_Timer2_timeout():
	$Timer2.stop();
	queue_free();
