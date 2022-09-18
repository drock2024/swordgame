extends Node2D

var activated = false;

const BatBoss = preload("res://Enemies/BatBoss/BatBoss.tscn");

# Called when the node enters the scene tree for the first time.
func _ready():
	if PlayerStats.bat_defeated == true:
		queue_free();
	$Label.hide();
	var font = DynamicFont.new();
	font.font_data = load ("res://UI/alagard.ttf");
	font.size = 11;
	$Label.set("custom_fonts/font", font);
	$AnimatedSprite.play("default")
	$AnimatedSprite.stop();

func _physics_process(delta):
	if $PlayerDetectionZone.can_see_player():
		$Label.show();
		if Input.is_action_just_pressed("ui_accept") and activated == false:
			activate_pedestal();
			activated = true;
	else:
		$Label.hide();

func activate_pedestal():
	$Label.hide();
	$AnimatedSprite.play("default");


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "default":
		$AnimatedSprite.play("Sink");
		Camera2d.shake(25, 1.5);
	else:
		var batBoss = BatBoss.instance();
		get_parent().add_child(batBoss);
		batBoss.global_position = Vector2(270, -32);
		queue_free();
