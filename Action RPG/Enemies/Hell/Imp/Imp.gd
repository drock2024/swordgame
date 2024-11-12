extends "res://Enemies/Bat.gd"

var fired = false;

onready var Fireball = preload("res://Enemies/Acorn/AcornBullet.tscn")
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
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			if target != null:
				var fire_dir = (target.global_position - global_position).normalized();
				if fired == false:
					var bullet = Fireball.instance();
					bullet.scale = Vector2(0.5, 0.5)
					get_parent().add_child(bullet)
					bullet.dir = fire_dir;
					bullet.global_position = global_position - Vector2(0,8);
					fired = true;
					$ShotTimer.start(1)
			else:
				state = IDLE;
				
func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE;

func seek_target():
	if shootZone.can_see_player():
		state = SHOOT;

func _on_ShotTimer_timeout():
	fired = false;
