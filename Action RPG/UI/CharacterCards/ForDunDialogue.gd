extends Node2D

const DialogBox = preload("res://ForDunDialogueBox.tscn");
const PrizeDialogBox = preload("res://UI/CharacterCards/PrizeDialogBox.tscn");

var active = false
var done = false
var done2 = false
var canvas = null
var anim_stage = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	Player.set_physics_process(false);
	$CloakEyes.play("wake")

func _process(delta):
	initDialog();
	initPrizeDialog();

func initPrizeDialog():
	if !done2 && PlayerStats.prizeDialog == true:
		print("Bruhmst")
		canvas = $CanvasLayer
		var dialogBox = PrizeDialogBox.instance();
		canvas.add_child(dialogBox);
		dialogBox.set_anchors_preset(2);
		done2 = true;

func initDialog():
	if !done:
		canvas = $CanvasLayer
		var dialogBox = DialogBox.instance();
		canvas.add_child(dialogBox);
		dialogBox.set_anchors_preset(2);
		done = true;

func _on_CloakEyes_animation_finished():
	if anim_stage == 1:
		$CloakEyes.play("shine")
		$Light2D.show()
		$Light2D2.show()
		anim_stage += 1
	elif anim_stage == 2:
		$CloakEyes.play("idle")
