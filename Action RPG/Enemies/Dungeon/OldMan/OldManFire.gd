extends Node2D

var counter = 0
var curr_fire = 0
var rotation_values = [0, 90, 180, 270]
var spawnDir = 999

func _ready():
	randomize()
	rotation_values.shuffle()
	spawnDir = rotation_values[0]
	$Timer.start(0.5)
	#rotation_degrees = rotation_value
	$YSort/FireSource1/Hitbox.set_collision_mask_bit(2, false)
	$YSort/FireSource2/Hitbox.set_collision_mask_bit(2, false)
	$YSort/FireSource3/Hitbox.set_collision_mask_bit(2, false)
	$YSort/FireSource4/Hitbox.set_collision_mask_bit(2, false)
	$YSort/FireSource5/Hitbox.set_collision_mask_bit(2, false)
	$YSort/FireSource6/Hitbox.set_collision_mask_bit(2, false)
	$YSort/FireSource7/Hitbox.set_collision_mask_bit(2, false)
	$YSort/FireSource8/Hitbox.set_collision_mask_bit(2, false)


func _on_Timer_timeout():
	$Timer.stop()
	curr_fire = $YSort.get_child(counter)
	curr_fire.visible = true;
	curr_fire.play("activate")
	if spawnDir == 0:
		for n in 8:
			$YSort.get_child(n).position.x = $YSort/FireSource1.position.x + (16*n)
#	if spawnDir == 45:
#		for n in 8:
#			$YSort.get_child(n).position.x = $YSort/FireSource1.position.x + (16*n)
#			$YSort.get_child(n).position.y = $YSort/FireSource1.position.y - (16*n)
	if spawnDir == 90:
		for n in 8:
			$YSort.get_child(n).position.x = $YSort/FireSource1.position.x
			$YSort.get_child(n).position.y = $YSort/FireSource1.position.y - (16*n)
#	if spawnDir == 135:
#		for n in 8:
#			$YSort.get_child(n).position.x = $YSort/FireSource1.position.x - (16*n)
#			$YSort.get_child(n).position.y = $YSort/FireSource1.position.y - (16*n)
	if spawnDir == 180:
		for n in 8:
			$YSort.get_child(n).position.x = $YSort/FireSource1.position.x - (16*n)
#	if spawnDir == 225:
#		for n in 8:
#			$YSort.get_child(n).position.x = $YSort/FireSource1.position.x - (16*n)
#			$YSort.get_child(n).position.y = $YSort/FireSource1.position.y + (16*n)
	if spawnDir == 270:
		for n in 8:
			$YSort.get_child(n).position.x = $YSort/FireSource1.position.x
			$YSort.get_child(n).position.y = $YSort/FireSource1.position.y + (16*n)
	if counter < 7:
		counter += 1
	else:
		curr_fire.play("active")
	$Timer.start(0.5)
	$Timer2.start(0.42)

func _on_Timer2_timeout():
	curr_fire.play("active")
	$YSort.get_child(counter).get_child(0).set_collision_mask_bit(2, true)
	$Timer2.stop()
