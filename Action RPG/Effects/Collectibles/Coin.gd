extends Node2D

const Noise = preload("res://Effects/Collectibles/CoinPickup.tscn");


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayerDetectionZone_body_entered(body):
	PlayerStats.change_money(1);
	var noise = Noise.instance();
	get_parent().add_child(noise);
	noise.global_position = body.global_position - Vector2(0,24);
	queue_free();
