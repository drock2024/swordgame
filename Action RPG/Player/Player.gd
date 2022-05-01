extends KinematicBody2D

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")
const HealEffect = preload("res://Effects/HealEffect.tscn");

export var ACCELERATION = 500;
export var MAX_SPEED = 80;
export var ROLL_SPEED = 125;
export var FRICTION = 400;
export(String) var CLASS = "BASE";

signal room_test;
signal room_back;
signal room_up;
signal room_down;

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE;
var velocity = Vector2.ZERO;
var roll_vector = Vector2.DOWN;
var stats = PlayerStats;
var bruh = true;
var room_array = ["res://World/TestRoom.tscn", "res://World/TestRoom2.tscn"]
var vert_array = ["res://World/Levels/FOrest/ForestRoom1.tscn", "res://World/TestRoomUp.tscn"]
var section_array_1 = ["res://World/TestRoomDown.tscn",  "res://World/Levels/FOrest/ForestBoss.tscn"]
var section_array_2 = ["res://World/Levels/FOrest/ForestRoom1.tscn", "res://World/TestRoomUp.tscn"]
var room_map = [];
var current_room = "res://World.tscn";
var cooldown = true;
var invis_length = 4;
var prince_length = 6;
var og_pos = Vector2.ZERO;
var defenseLight = false;
var healable = true;


onready var animationPlayer = $AnimationPlayer;
onready var animationTree = $AnimationTree;
onready var animationState = animationTree.get("parameters/playback");
onready var swordHitbox = $HitboxPivot/SwordHitbox;
onready var hitBoxShape = $HitboxPivot/SwordHitbox/CollisionShape2D;
onready var hurtBox = $Hurtbox;
onready var blinkAnimationPlayer = $BlinkAnimationPlayer;
onready var abilityTimer = $DurationTimer;
onready var cooldownTimer = $CooldownTimer;
onready var collision = $CollisionShape2D;
onready var hurtBoxCollision = $HitboxPivot/SwordHitbox/CollisionShape2D;

func _ready():
	randomize();
	stats.connect("no_health", self, "queue_free");
	stats.connect("health_increase", self, "heal_effect");
	animationTree.active = true;
	swordHitbox.knockback_vector = roll_vector;
	CLASS = stats.player_class;
	$Particles2D.emitting = false;
	$GlowSound.playing = false;
	#room_array.shuffle();
	#vert_array.shuffle();
	room_map = create_2d_array(room_array, vert_array);
	if CLASS == "BASE":
		$Sprite.texture = load("res://Player/Player.png");
	elif CLASS == "ROGUE":
		$Sprite.texture = load("res://Player/Rogue.png");
	elif CLASS == "PRINCE":
		$Sprite.texture = load("res://Player/SpriteSheets/Prince.png");
	elif CLASS == "PALADIN":
		$Sprite.texture = load("res://Player/SpriteSheets/Paladin.png");

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta);
		ROLL:
			roll_state(delta);
		ATTACK:
			attack_state(delta);
	#Check if day time
	if stats.time_of_day == "day":
		$Light2D.set_texture_scale(0)
	else:
		$Light2D.set_texture_scale(0.12)
	#Check input for ability activation
	if Input.is_action_just_pressed("ability") and cooldown == true:
		activate_ability();
		cooldown = false;

func create_2d_array(array_1, array_2):
	var a = [array_1, array_2]
	return a

func set_spawn(location: Vector2, direction: Vector2):
	position = location;

func move_state(delta):
	var input_vector = Vector2.ZERO;
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
	input_vector = input_vector.normalized();
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector;
		swordHitbox.knockback_vector = input_vector;
		animationTree.set("parameters/Idle/blend_position", input_vector);
		animationTree.set("parameters/Run/blend_position", input_vector);
		animationTree.set("parameters/Attack/blend_position", input_vector);
		animationTree.set("parameters/Roll/blend_position", input_vector);
		animationState.travel("Run");
		if CLASS == "ROGUE":
			velocity = velocity.move_toward(input_vector * MAX_SPEED * 1.2, ACCELERATION * delta);
		elif CLASS == "PRINCE":
			velocity = velocity.move_toward(input_vector * MAX_SPEED * 1.1, ACCELERATION * delta);
		elif CLASS == "PALADIN":
			velocity = velocity.move_toward(input_vector * MAX_SPEED * 0.9, ACCELERATION * delta);
		else:
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta);
	else:
		animationState.travel("Idle");
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta);
	
	move();
	
	if Input.is_action_just_pressed("roll"):
		state = ROLL;
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK;
	
	
	if bruh == true && $DoorDetector.colliding_with_door():
		if position.x < 50 and position.y > 32 and position.y < (Camera2d.bottomRight.position.y - 32):
			emit_signal("room_back");
		elif position.x > 220 and position.y > 32 and position.y < (Camera2d.bottomRight.position.y - 32):
			emit_signal("room_test");
		elif position.y < 32:
			emit_signal("room_up");
		elif position.y > (Camera2d.bottomRight.position.y - 32):
			emit_signal("room_down");

func roll_state(delta):
	velocity = roll_vector * ROLL_SPEED;
	animationState.travel("Roll");
	move();
	if bruh == true && $DoorDetector.colliding_with_door():
		if position.x < 50 and position.y > 32 and position.y < (Camera2d.bottomRight.position.y - 32):
			emit_signal("room_back");
		elif position.x > 220 and position.y > 32 and position.y < (Camera2d.bottomRight.position.y - 32):
			emit_signal("room_test");
		elif position.y < 32:
			emit_signal("room_up");
		elif position.y > (Camera2d.bottomRight.position.y - 32):
			emit_signal("room_down");

func attack_state(delta):
	velocity = Vector2.ZERO;
	animationState.travel("Attack");
	if CLASS == "PALADIN":
		hitBoxShape.set_scale(Vector2(1.2, 1.2));
	
func move():
	velocity = move_and_slide(velocity);

func roll_animation_finished():
	velocity = velocity / 2;
	state = MOVE;
	
func attack_animation_finished():
	state = MOVE;

func activate_ability():
	if CLASS == "ROGUE":
		$Sprite.modulate.a = 0.5;
		abilityTimer.start(invis_length);
		set_collision_layer_bit(1, false);
	if CLASS == "PRINCE":
		$Sprite.texture = load("res://Player/SpriteSheets/PrinceAbility.png");
		abilityTimer.start(prince_length);
		hitBoxShape.set_scale(Vector2(1, 2.8));
		hitBoxShape.rotation_degrees = 90;
		og_pos = swordHitbox.position;
		if swordHitbox.rotation_degrees == 0:
			swordHitbox.position += Vector2(24,0);
		elif swordHitbox.rotation_degrees == 180:
			swordHitbox.position -= Vector2(24,0);
		#Set particle flash
		$FlashTimer.start(0.4);
		$PrinceParticles.emitting = true;
	if CLASS == "PALADIN":
		$Particles2D.emitting = true;
		abilityTimer.start(invis_length);
		#hurtBox.invincible = true;
		#hurtBox.set_process(false);
		defenseLight = true;
		$GlowSound.playing = true;
		
	

func _on_Hurtbox_area_entered(area):
	if defenseLight == false:
		stats.health -= area.damage;
		hurtBox.start_invincibility(0.6);
		hurtBox.create_hit_effect();
		var playerHurtSound = PlayerHurtSound.instance()
		get_tree().current_scene.add_child(playerHurtSound)


func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start");

func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop");

func _on_DurationTimer_timeout():
	if CLASS == "ROGUE":
		$Sprite.modulate.a = 1;
		abilityTimer.stop();
		cooldownTimer.start(10);
		set_collision_layer_bit(1, true);
	elif CLASS == "PRINCE":
		$Sprite.texture = load("res://Player/SpriteSheets/Prince.png");
		abilityTimer.stop();
		cooldownTimer.start(15);
		hitBoxShape.set_scale(Vector2(1, 1));
		hitBoxShape.rotation_degrees = 0;
		swordHitbox.position = og_pos;
	elif CLASS == "PALADIN":
		$Particles2D.emitting = false;
		abilityTimer.stop();
		cooldownTimer.start(12);
		#hurtBox.invincible = false;
		defenseLight = false;
		$GlowSound.playing = false;

func _on_CooldownTimer_timeout():
	cooldownTimer.stop();
	cooldown = true;


func _on_FlashTimer_timeout():
	$FlashTimer.stop();
	$PrinceParticles.emitting = false;

func heal_effect():
	var heal = HealEffect.instance();
	get_parent().add_child(heal);
	heal.global_position = global_position - Vector2(0,16);

func use_health_dagger():
	if stats.daggers > 0 and stats.health < stats.max_health:
		print("Bruh")
		stats.daggers -= 1;
		stats.health += 1;
		stats.increase_health();

func _on_HealTimer_timeout():
	healable = true;
	$HealTimer.stop();
