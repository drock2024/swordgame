extends "res://Enemies/Bat.gd"

var wake_flag = false;

func _ready():
	$AnimatedSprite.play("Idle")

func _physics_process(delta):
	match state:
		IDLE:
			$AnimatedSprite.stop();
			$AnimatedSprite.set_frame(0);
			seek_player_mimic();
		
		WANDER:
			state = IDLE;
		
		WAKE:
			$AnimatedSprite.play("Wake")
			seek_player_mimic();
			if $AnimatedSprite.get_frame() >= 3:
				wake_flag = true;
				state = CHASE;
			
		CHASE:
			$AnimatedSprite.play("Active");
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta*1.1);
			else:
				state = IDLE;

func seek_player_mimic():
	if playerDetectionZone.can_see_player():
		if wake_flag:
			state = CHASE;
		else:
			state = WAKE;

func _on_Stats_no_health():
	queue_free();
	var enemyDeathEffect = EnemyDeathEffect.instance();
	get_parent().add_child(enemyDeathEffect);
	enemyDeathEffect.global_position = global_position;
