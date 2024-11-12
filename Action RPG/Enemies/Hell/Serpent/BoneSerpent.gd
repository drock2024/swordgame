extends "res://Enemies/Bat.gd"

var fired = false;
var firing = false;

onready var SnakeHead = preload("res://Enemies/Hell/Serpent/SnakeHead.tscn")
onready var shootZone = $ShootDetectionZone

func _physics_process(delta):
	match state:
		CHASE:
			seek_target();
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta);
			else:
				state = IDLE;
		
		SHOOT:
			var target = shootZone.player
			velocity = Vector2.ZERO
			if target != null:
				var fire_dir = (target.global_position - global_position).normalized();
				if fired == false && firing == false:
					$AnimatedSprite.hide()
					var bullet = SnakeHead.instance();
					add_child(bullet)
					bullet.dir = fire_dir;
					bullet.global_position = global_position - Vector2(0,8);
					bullet.target_distance = global_position.distance_to(target.global_position)
					bullet.origin_pos = global_position
					fired = true;
					firing = true;
					$ShotTimer.start(3)
				
func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE;

func seek_target():
	if shootZone.can_see_player():
		state = SHOOT;

func _on_ShotTimer_timeout():
	fired = false;


func _on_Hitbox_area_entered(area):
	state = IDLE;
	firing = false;
	$AnimatedSprite.show()
