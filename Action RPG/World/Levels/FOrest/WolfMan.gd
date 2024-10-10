extends Sprite

const DialogBox = preload("res://Dialogue.tscn");

var active = false;
var done = false;
var canvas = null

func _ready():
	if PlayerStats.time_of_day == "night":
		visible = true;

func _process(delta):
	if active && Input.is_action_just_pressed("ui_accept"):
		initDialog();
		active = false;

func _on_PlayerDetectionZone_body_entered(body):
	active = true;

func _on_PlayerDetectionZone_body_exited(body):
	active = false;
	
func initDialog():
	if !done:
		if PlayerStats.area == "Forest":
			canvas = find_parent("YSort").find_parent("ForestRoom2").get_child(6);
			PlayerStats.found_wolf = true;
		else:
			canvas = find_parent("YSort").find_parent("DungeonRoom1").get_child(7);
		var dialogBox = DialogBox.instance();
		canvas.add_child(dialogBox);
		dialogBox.set_anchors_preset(2);
		done = true;
