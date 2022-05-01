extends "res://Enemies/Bat.gd"

var wake_flag = false;
var fired = false;

onready var AcornBullet = preload("res://Enemies/Acorn/AcornBullet.tscn");

func _ready():
	$AnimatedSprite.play("Idle")

func _physics_process(delta):
	match state:
		IDLE:
			$AnimatedSprite.play("Idle");
			seek_player_acorn();
			$Hurtbox/CollisionShape2D.disabled = true;
		
		WANDER:
			state = IDLE;
		
		WAKE:
			$AnimatedSprite.play("Wake")
			seek_player_acorn();
			$Hurtbox/CollisionShape2D.disabled = false;
			if $AnimatedSprite.get_frame() >= 4:
				state = SHOOT;
		CHASE:
			state = IDLE;
		
		SHOOT:
			$AnimatedSprite.play("Attack");
			var player = playerDetectionZone.player;
			if player != null:
				var fire_dir = (player.global_position - global_position).normalized();
				if fired == false:
					var bullet = AcornBullet.instance();
					add_child(bullet)
					bullet.dir = fire_dir;
					bullet.global_position = global_position - Vector2(0,8);
					fired = true;
					$ShotTimer.start(1)
			else: 
				state = SLEEP;
		SLEEP:
			$AnimatedSprite.play("Sleep")
			if $AnimatedSprite.get_frame() >= 3:
				state = IDLE;
			

func seek_player_acorn():
	if playerDetectionZone.can_see_player():
			state = WAKE;

func _on_ShotTimer_timeout():
	fired = false;
