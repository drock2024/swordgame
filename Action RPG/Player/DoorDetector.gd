extends Area2D

func _ready():
	pass # Replace with function body.

func colliding_with_door():
	if get_overlapping_bodies():
		#print(get_overlapping_bodies())
		return true;

func colliding_with_back_door():
	if get_overlapping_areas():
		return true;
