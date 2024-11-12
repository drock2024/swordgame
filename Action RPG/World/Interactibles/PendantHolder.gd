extends Node2D

var activated = false;
var phase = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("inactive");
	$Label.hide();
	var font = DynamicFont.new();
	font.font_data = load ("res://UI/alagard.ttf");
	font.size = 11;
	$Label.set("custom_fonts/font", font);

func _physics_process(delta):
	if $PlayerDetectionZone.can_see_player():
		if activated == false and PlayerStats.obj >= 2:
			$Label.show();
			if Input.is_action_just_pressed("ui_accept"):
				activate_pendant();
				phase = 1;
				activated = true;
	else:
		$Label.hide();
		
func activate_pendant():
	$Label.hide();
	$AnimatedSprite.play("insert");
	

func _on_AnimatedSprite_animation_finished():
	if phase == 1:
		$AnimatedSprite.play("rise");
		phase = 2;
	elif phase == 2:
		$AnimatedSprite.play("active");
		phase = 3;
	elif phase == 3:
		PlayerStats.health = 4
		get_tree().change_scene("res://UI/CharacterCards/ForDunDialogue.tscn")
		#get_node(NodePath("/root/SceneManager")).transition_to_scene("res://World/Levels/FOrest/CastleBackdrop.tscn", Vector2(-1, -1), Vector2(-1, -1));
