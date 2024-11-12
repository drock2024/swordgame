extends "res://World/Levels/Dungeon/DungeonRoom1.gd"

onready var ladderDown = $YSort/LadderDown;
onready var ladderUp = $YSort/LadderUp;

const PostDialog = preload("res://Enemies/Dungeon/OldMan/WardenDeathDialog.tscn");

var laddersCalled = false;
var done = false;
var canvas = null;

func _ready():
	PlayerStats.time_of_day = "day";
	PlayerStats.old_boss = true;
	$AudioStreamPlayer.play();
	ladderDown.hide();
	ladderUp.hide();

func _process(_delta):
	if PlayerStats.oldManDefeated:
		show_ladders();

func initDialog():
	if !done:
		canvas = $CanvasLayer
		var dialogBox = PostDialog.instance();
		canvas.add_child(dialogBox);
		dialogBox.set_anchors_preset(2);
		done = true;

func show_ladders():
	initDialog();
	if Player.CLASS == "PALADIN" or Player.CLASS == "BASE" or Player.class == "WOLF":
		ladderDown.show();
		$YSort/LadderDown/Area2D.set_collision_layer_bit(0, true);
	if Player.CLASS == "PRINCE" or Player.CLASS == "ROGUE" or Player.CLASS == "BASE":
		ladderUp.show();
		$YSort/LadderUp/Area2D2.set_collision_layer_bit(0, true);


func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://World/Levels/FOrest/CastleBackdrop.tscn");
