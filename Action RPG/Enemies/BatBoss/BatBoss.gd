extends "res://Enemies/Bat.gd"

export (int) var speed = 70;

const Bullet = preload("res://Enemies/Acorn/AcornBullet.tscn");
const BatTarget = preload("res://Enemies/BatBoss/TargetSprite.tscn");
const Shadow = preload("res://Shadows/BatShadow.tscn");
const Acorn = preload("res://Enemies/Acorn/Acorn.tscn");

var awake = false;
var target = Vector2(270, 115);
var sceneTargets = [Vector2(-64, 200), Vector2(-64, 0), Vector2(464, 200), Vector2(270, -64)];
var sceneStage = 0;
var vel = Vector2();
var fired = false;
var bulletCount = 0;
var attackPos = 1;
var divePos = false;
var diveSequence = 0;
var targets = [Vector2(48, 80), Vector2(150, 80), Vector2(270, 80)];
var diveFlag = true;
var chaseDir = Vector2();
var lungeReady = false;


onready var collision = $CollisionShape2D;

func _ready():
	state = IDLE;
	var shadow = Shadow.instance();
	add_child(shadow);
	shadow.global_position = global_position + Vector2(0, 16);

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta);
	knockback = move_and_slide(knockback);
	
	match state:
		IDLE:
			collision.disabled = false;
			$AnimatedSprite.play("Idle");
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			boss_stages();
		
		WAKE:
			collision.disabled = true;
			PlayerStats.bat_summoned = true;
			$Hurtbox.set_process(false);
			$Hitbox/CollisionShape2D.disabled = true;
			if awake == false:
				$AnimatedSprite.hide();
				vel = position.direction_to(sceneTargets[sceneStage]) * 240;
				if position.distance_to(sceneTargets[sceneStage]) > 5:
					vel = move_and_slide(vel)
				else:
					if sceneStage < 3:
						sceneStage += 1;
					else:
						awake = true;
			else:
				$Hurtbox.set_process(true);
				$Hitbox/CollisionShape2D.disabled = false;
				$AnimatedSprite.show();
				$AnimatedSprite.play("Idle");
				vel = position.direction_to(target) * speed
				if position.distance_to(target) > 5:
					vel = move_and_slide(vel)
				else:
					state = IDLE;

		WANDER:
			state = IDLE;
		
		SHOOT:
			collision.disabled = false;
			var player = playerDetectionZone.player;
			if player != null:
				var fire_dir = (player.global_position - global_position).normalized();
				if fired == false:
					if bulletCount < 7:
						var bullet = Bullet.instance();
						get_parent().add_child(bullet)
						bullet.dir = fire_dir;
						bullet.speed = 100;
						bullet.global_position = global_position - Vector2(0,8);
						fired = true;
						$ShotTimer.start(0.5)
					else:
						bulletCount = 0;
						fired = true;
						$ShotTimer.stop();
						$Timer.start(1.75);
		
		ATTACK:
			collision.disabled = false;
			if attackPos == 0:
				target = Vector2(270, 115);
				$AnimatedSprite.flip_h = false;
			elif attackPos == 1:
				target = Vector2(70, 115);
				$AnimatedSprite.flip_h = true;
			elif attackPos == 2:
				target = Vector2(270, 60);
				$AnimatedSprite.flip_h = false;
			elif attackPos == 3:
				target = Vector2(70, 60);
				$AnimatedSprite.flip_h = true;
			vel = position.direction_to(target) * 200;
			if position.distance_to(target) > 5:
				vel = move_and_slide(vel)
			else:
				$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h;
				if attackPos < 3:
					attackPos += 1;
				else:
					attackPos = 0;
				state = IDLE;
		
		CHASE:
			#var player = playerDetectionZone.player
			#if player != null:
			#	accelerate_towards_point(player.global_position, delta);
			#else:
			state = IDLE;
		DIVE:
			collision.disabled = true;
			if divePos == false:
				target = Vector2(150, -128);
				$AnimatedSprite.play("Idle");
				vel = position.direction_to(target) * 120;
				if position.distance_to(target) > 5:
					vel = move_and_slide(vel)
				else:
					divePos = true;
					var batTarget = BatTarget.instance();
					get_parent().add_child(batTarget);
					batTarget.global_position = targets[diveSequence];
			if divePos == true:
				target = targets[diveSequence];
				$AnimatedSprite.play("Dive");
				vel = position.direction_to(target) * 280;
				if position.distance_to(target) > 5:
					vel = move_and_slide(vel)
				else:
					if diveFlag == true:
						$DiveTimer.start(0.5);
						diveFlag = false;
		CHARGE:
			$AnimatedSprite.play("Idle");
			if playerDetectionZone.player != null:
				collision.disabled = false;
				if lungeReady == true:
					if position.distance_to(target) > 4:
						$AnimatedSprite.flip_h = chaseDir.x;
						move_and_slide(chaseDir * 200);
					else:
						lungeReady = false;
						$LungeTimer.start(1);

func _on_Stats_no_health():
	PlayerStats.bat_summoned = false;
	PlayerStats.bat_defeated = true;
	queue_free();
	var enemyDeathEffect = EnemyDeathEffect.instance();
	PlayerStats.set_obj(PlayerStats.obj + 1)
	get_parent().add_child(enemyDeathEffect);
	enemyDeathEffect.global_position = global_position;

func boss_stages():
	if awake == true:
		if stats.health >= (stats.max_health*0.75):
			state = SHOOT;
		elif stats.health >= (stats.max_health*0.5) and stats.health <= (stats.max_health*0.75):
			state = DIVE;
		elif stats.health < (stats.max_health*0.5):
			var player = playerDetectionZone.player;
			if player != null:
				chaseDir = (player.global_position - global_position).normalized();
				target = player.global_position - (chaseDir * 4);
			$LungeTimer.start(1);
			state = CHARGE;
	else:
		state = WAKE;

func seek_player():
	boss_stages();

func _on_ShotTimer_timeout():
	fired = false;
	bulletCount += 1;


func _on_Timer_timeout():
	$Timer.stop();
	state = ATTACK;
	fired = false;


func _on_DiveTimer_timeout():
	$DiveTimer.stop();
	boss_stages();
	if diveSequence < 2:
		diveSequence += 1;
		divePos = false;
		diveFlag = true;
	else:
		diveSequence = 0;
		divePos = false;
		diveFlag = true;


func _on_LungeTimer_timeout():
	lungeReady = true;
	state = IDLE;
