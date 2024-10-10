extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn");
const Coin = preload("res://Effects/Collectibles/Coin.tscn");

var attack_dir = Vector2(0,0)
var speed = 3
var collision_count = 0
var active = false
var woke = false
var cooled_down = true
var player = 0
var collision = 0
var reflect = 0

onready var rest = $Rest
onready var sprite = $AnimatedSprite
onready var stats = $Stats

enum {
	IDLE,
	WAKE,
	CHASE
}
var state = IDLE

func _ready():
	pass

func _physics_process(delta):
	match state:
		IDLE:
			sprite.animation = "down"
		WAKE:
			sprite.animation = "default"
		CHASE:
			if active:
				sprite.animation = "right"
				rotation = attack_dir.angle()
				#move_and_collide(attack_dir * delta * speed)
				collision = move_and_collide(attack_dir * delta * speed)
				if collision:
					collision_count += 1
					if collision_count < 3:
						attack_dir = attack_dir.bounce(collision.get_normal())
					else:
						active = false
						state = WAKE
						collision_count = 0
					

func _on_PlayerDetectionZone_body_entered(body):
	if active == false:
		attack_dir = Vector2(body.position.x - position.x, body.position.y - position.y)
		active = true
		if woke == false:
			state = WAKE
			woke = true
			rest.start(1.5)
		else:
			state = CHASE
	#attack_dir = Vector2(attack_dir.x / abs(attack_dir.x), attack_dir.y / abs(attack_dir.y))


func _on_Rest_timeout():
	state = CHASE


func _on_Stats_no_health():
	queue_free();
	var enemyDeathEffect = EnemyDeathEffect.instance();
	get_parent().add_child(enemyDeathEffect);
	enemyDeathEffect.global_position = global_position;
	var coin = Coin.instance();
	get_parent().add_child(coin);
	coin.global_position = global_position;


func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage;
