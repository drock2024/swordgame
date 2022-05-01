extends KinematicBody2D

export(Vector2) var spawn_location = Vector2(0, 0);
export(Vector2) var spawn_direction = Vector2(0, 0);

func _ready():
	var player = find_parent("CurrentScene").get_children().back().find_node("Player")
	player.connect("room_test", self, "enter_door");
	player.connect("room_back", self, "enter_back_door");
	player.connect("room_up", self, "enter_top_door");
	player.connect("room_down", self, "enter_bottom_door");
	
	
func enter_door():
	if PlayerStats.bat_summoned == false:
		#get_node(NodePath("/root/SceneManager")).transition_to_scene("res://World.tscn");
		spawn_location = Vector2(16, 80);
		get_node(NodePath("/root/SceneManager")).player_change_room(spawn_location, spawn_direction);

func enter_back_door():
	if PlayerStats.bat_summoned == false:
		spawn_location = Vector2(320, 116)
		get_node(NodePath("/root/SceneManager")).player_back_room(spawn_location, spawn_direction);

func enter_top_door():
	if PlayerStats.bat_summoned == false:
		spawn_location = Vector2(160, 160)
		get_node(NodePath("/root/SceneManager")).player_up_room(spawn_location, spawn_direction);

func enter_bottom_door():
	if PlayerStats.bat_summoned == false:
		spawn_location = Vector2(160, 24)
		get_node(NodePath("/root/SceneManager")).player_down_room(spawn_location, spawn_direction);
