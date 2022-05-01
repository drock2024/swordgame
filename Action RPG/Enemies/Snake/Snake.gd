extends "res://Enemies/Bat.gd"

func _physics_process(delta):
	match state:
		IDLE:
			$AnimatedSprite.play("Move2");
			$AnimatedSprite.stop();
			$AnimatedSprite.set_frame(0);
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player();
			attack_player();
			if wanderController.get_time_left() == 0:
				update_wander();
				
		WANDER:
			$AnimatedSprite.play("Move2");
			seek_player();
			if wanderController.get_time_left() == 0:
				update_wander();
			accelerate_towards_point(wanderController.target_position, delta);
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander();
			
		CHASE:
			$AnimatedSprite.play("Move2");
			var player = playerDetectionZone.player
			attack_player();
			if player != null:
				accelerate_towards_point(player.global_position, delta);
			else:
				state = IDLE;
		ATTACK:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			var player = $AttackZone.player
			if player != null:
				$AnimatedSprite.play("Attack2");
			else:
				state = IDLE;
			

func attack_player():
	if $AttackZone.can_see_player():
		state = ATTACK;
