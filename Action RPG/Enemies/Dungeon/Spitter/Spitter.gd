extends "res://Enemies/Bat.gd"

onready var Wafer = preload("res://Effects/Collectibles/Wafer.tscn")
var color = "Green"


func _ready():
	if position.x > 375:
		$AnimatedSprite.animation = "SpitterGreen"
		color = "Green"
	if position.x < 375 && position.x > -250:
		$AnimatedSprite.animation = "SpitterRed"
		color = "Red"
	if position.x < -250:
		$AnimatedSprite.animation = "SpitterBlue"
		color = "Blue"
		
func _on_Stats_no_health():
	queue_free();
	var enemyDeathEffect = EnemyDeathEffect.instance();
	get_parent().add_child(enemyDeathEffect);
	enemyDeathEffect.global_position = global_position;
	var coin = Coin.instance();
	get_parent().add_child(coin);
	coin.global_position = global_position;
	var wafer = Wafer.instance();
	get_parent().add_child(wafer);
	wafer.global_position = global_position;
	wafer.get_node("AnimatedSprite").play(color)
	wafer.color = color
	
