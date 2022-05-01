extends "res://Enemies/Bat.gd"


func _physics_process(delta):
	match state:
		IDLE:
			$AnimatedSprite.stop();
			$AnimatedSprite.set_frame(0);
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player();
			if wanderController.get_time_left() == 0:
				update_wander();
				
		WANDER:
			$AnimatedSprite.play();
			seek_player();
			if wanderController.get_time_left() == 0:
				update_wander();
			accelerate_towards_point(wanderController.target_position, delta);
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander();
			
		CHASE:
			$AnimatedSprite.play();
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta);
			else:
				state = IDLE;
