extends KinematicBody2D

var dir = Vector2(0, 0);
var speed = 80;

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	move_and_slide(dir * speed);
	var deg_per_sec = 720.0;
	rotate(delta * deg2rad(deg_per_sec));


func _on_Hitbox_body_entered(body):
	dir = -dir;
	print("bruh");
