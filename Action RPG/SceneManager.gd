extends Node2D

onready var currentScene = $CurrentScene;

var next_scene = null;
var prev_scene = null;
var room_flag = 0;
var section = 0;
var pause_flag = false;
var time_array = [];
var save_array = [];

var player_location = Vector2(0, 0);
var player_direction = Vector2(0, 0);

var hor_index = -1;
var vert_index = 0;

var rows = Player.room_array.size() - 1;
var cols = Player.vert_array.size() - 1;

func _ready():
	#player.connect("room_test", self, "player_change_room");
	randomize();
	Player.room_map.shuffle();
	save_array = Player.room_map;
	print(Player.room_map.size())
	prev_scene = Player.current_room;
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), 0)
	if PlayerStats.player_class == "BASE":
		time_array.push_front("day");
		time_array.push_front("day");
		time_array.push_front("night");
		time_array.shuffle();
		PlayerStats.time_of_day = time_array[0];
	elif PlayerStats.player_class == "ROGUE":
		time_array.push_front("night");
		time_array.push_front("night");
		time_array.push_front("night");
		time_array.push_front("night");
		time_array.push_front("day");
		time_array.shuffle();
		PlayerStats.time_of_day = time_array[0];
	elif PlayerStats.player_class == "PRINCE":
		time_array.push_front("day");
		time_array.push_front("day");
		time_array.push_front("day");
		time_array.push_front("day");
		time_array.push_front("night");
		time_array.shuffle();
		PlayerStats.time_of_day = time_array[0];
	elif PlayerStats.player_class == "PALADIN":
		time_array.push_front("day");
		time_array.push_front("night");
		time_array.push_front("night");
		time_array.shuffle();
		PlayerStats.time_of_day = time_array[0];
	if PlayerStats.time_of_day == "day":
		Camera2d.color.hide();
	else:
		Camera2d.color.show();
	print(PlayerStats.time_of_day)

func _physics_process(delta):
	if Input.is_action_just_pressed("heal"):
		Player.healable = false;
		Player.use_health_dagger();

func transition_to_scene(new_scene: String, spawn_location, spawn_direction):
	next_scene = new_scene;
	player_location = spawn_location;
	player_direction = spawn_direction;
	$ScreenTransition/AnimationPlayer.play("FadeToBlack");

func finished_fading():
	currentScene.get_child(0).queue_free();
	currentScene.add_child(load(next_scene).instance());
	
	var player = $CurrentScene.get_children().back().find_node("Player")
	player.set_spawn(player_location, player_direction)
	
	$ScreenTransition/AnimationPlayer.play("FadeToNormal");
	if room_flag == 0:
		hor_index += 1;
		print("Right ", hor_index, vert_index)
	elif room_flag == 1:
		hor_index -= 1;
		print("Left ", hor_index, vert_index)
	elif room_flag == 2:
		vert_index += 1;
		print("Down ", hor_index, vert_index)
	elif room_flag == 3:
		vert_index -= 1;
		print("Up ", hor_index, vert_index)
	elif room_flag == 4:
		hor_index = 1;
		vert_index = 1;
		print("Section back ", hor_index, vert_index)

func player_change_room(spawn_location, spawn_direction):
	if hor_index < rows:
		room_flag = 0;
		transition_to_scene(Player.room_map[hor_index + 1][vert_index], spawn_location, spawn_direction);
		prev_scene = Player.current_room;
		Player.current_room = Player.room_map[hor_index + 1][vert_index];
	else:
		if vert_index == 1 and section == 0:
			Player.room_map = Player.create_2d_array(Player.section_array_1, Player.section_array_2);
			transition_to_scene(Player.room_map[0][0], spawn_location, spawn_direction);
			hor_index = -1;
			vert_index = 0;
			section = 1;
			prev_scene = Player.current_room;
			Player.current_room = Player.room_map[hor_index][vert_index];

func player_down_room(spawn_location, spawn_direction):
	room_flag = 2;
	if vert_index < cols:
		prev_scene = Player.current_room;
		transition_to_scene(Player.room_map[hor_index][vert_index + 1], spawn_location, spawn_direction);
		Player.current_room = Player.room_map[hor_index][vert_index + 1];

func player_back_room(spawn_location, spawn_direction):
	if hor_index > 0:
		room_flag = 1;
		prev_scene = Player.current_room;
		transition_to_scene(Player.room_map[hor_index - 1][vert_index], spawn_location, spawn_direction);
		Player.current_room = Player.room_map[hor_index - 1][vert_index];
	elif hor_index == 0 and vert_index == 0:
		if section == 0:
			room_flag = 1;
			print(section);
			transition_to_scene("res://World.tscn", spawn_location, spawn_direction);
			Player.current_room = "res://World.tscn";
		else:
			Player.room_map = save_array;
			transition_to_scene(Player.room_map[hor_index - 1][vert_index], spawn_location, spawn_direction);
			hor_index = 2;
			vert_index = 1;
			section = 0;
			Player.current_room = Player.room_map[hor_index - 1][vert_index];

func player_up_room(spawn_location, spawn_direction):
	room_flag = 3;
	if vert_index > 0:
		prev_scene = Player.current_room;
		transition_to_scene(Player.room_map[hor_index][vert_index - 1], spawn_location, spawn_direction);
		Player.current_room = Player.room_map[hor_index][vert_index - 1];
