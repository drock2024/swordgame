extends "res://Enemies/Bat.gd"

const SplitHound = preload("res://Enemies/Hell/Hellhound/HellhoundSplit.tscn")

func _physics_process(delta):
	match state:
		IDLE:
			$AnimatedSprite.play("Idle");
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
		
func _on_Stats_no_health():
	queue_free();
	var splitHound = SplitHound.instance();
	var splitHound2 = SplitHound.instance();
	get_parent().add_child(splitHound);
	get_parent().add_child(splitHound2);
	splitHound.global_position = global_position + Vector2(0, 32);
	splitHound2.global_position = global_position - Vector2(0, 32);
	var coin = Coin.instance();
	get_parent().add_child(coin);
	coin.global_position = global_position;

