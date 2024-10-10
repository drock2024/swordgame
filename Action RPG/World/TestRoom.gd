extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
		get_node(NodePath("/root/SceneManager")).connect("move_right", self, "moved_right");
		get_node(NodePath("/root/SceneManager")).connect("move_left", self, "moved_left");
		get_node(NodePath("/root/SceneManager")).connect("move_up", self, "moved_up");
		get_node(NodePath("/root/SceneManager")).connect("move_down", self, "moved_down");


func moved_right():
	$YSort/Player.position = $DoorPoint.position + Vector2(32, 0);

func moved_left():
	$YSort/Player.position = $DoorPoint2.position - Vector2(32, 0);
	
func moved_down():
	$YSort/Player.position = $DoorPoint4.position + Vector2(0, 32);
	
func moved_up():
	$YSort/Player.position = $DoorPoint3.position - Vector2(0, 32);
