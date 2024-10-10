extends Node2D

const DialogBox = preload("res://IntroDialogueBox.tscn");

var active = false
var done = false
var canvas = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	initDialog();
	#parallax bg
	$Background.position.x -= 5 * delta;
	$Background2.position.x -= 5 * delta;
	if $Background.position.x <= -160:
		$Background.position.x = 480;
	if $Background2.position.x <= -160:
		$Background2.position.x = 480;

func initDialog():
	if !done:
		canvas = $CanvasLayer
		var dialogBox = DialogBox.instance();
		canvas.add_child(dialogBox);
		dialogBox.set_anchors_preset(2);
		done = true;
