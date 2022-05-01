extends KinematicBody2D

export var ACCELERATION = 300;
export var MAX_SPEED = 50;
export var FRICTION = 200;

onready var outerZone = $PlayerDetectionZone

var velocity = Vector2.ZERO;
var move_flag = true;
var player;

onready var sprite = $Sprite;

func _physics_process(delta):
	player = outerZone.player;
	accelerate_towards_point(player.global_position, delta * 2)
	
func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point);
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0
