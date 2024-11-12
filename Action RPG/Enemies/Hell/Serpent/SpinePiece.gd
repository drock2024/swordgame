extends Node2D

var spawn_inv = true


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(0.2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	queue_free()


func _on_Timer_timeout():
	$Timer.stop()
	$Area2D.set_collision_layer_bit(2, true)
