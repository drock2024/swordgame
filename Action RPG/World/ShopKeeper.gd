extends Node2D

onready var playerDetectionZone = $PlayerDetectionZone
onready var orbButton = $VBoxContainer/Button;
onready var heartButton = $VBoxContainer/HeartButton;
onready var potionButton = $VBoxContainer/SlimeButton;

var orbCost = 10;
var heartCost = 4;
var potCost = 1;
var close = false;

func _ready():
	orbButton.grab_focus();
	var font = DynamicFont.new();
	font.font_data = load ("res://UI/alagard.ttf");
	font.size = 11;
	orbButton.set("custom_fonts/font", font);
	heartButton.set("custom_fonts/font", font);
	potionButton.set("custom_fonts/font", font);
	$HitEnter.set("custom_fonts/font", font);
	orbButton.disabled = true;
	heartButton.disabled = true;
	heartButton.hide();
	orbButton.hide();
	potionButton.disabled = true;
	potionButton.hide();

func _process(delta):
	if close and Input.is_action_just_pressed("ui_accept"):
		if PlayerStats.area == "Forest":
			if orbButton.disabled:
				orbButton.disabled = false;
				heartButton.disabled = false;
				orbButton.grab_focus();
				orbButton.show();
				heartButton.show();
		elif PlayerStats.area == "Dungeon":
			if heartButton.disabled:
				heartButton.disabled = false;
				heartButton.grab_focus();
				heartButton.show();
				potionButton.disabled = false;
				potionButton.show();

func _on_PlayerDetectionZone_body_entered(body):
#	orbButton.disabled = false;
#	heartButton.disabled = false;
#	orbButton.grab_focus();
#	orbButton.show();
#	heartButton.show();
	close = true;


func _on_PlayerDetectionZone_body_exited(body):
	orbButton.disabled = true;
	orbButton.hide();
	heartButton.disabled = true;
	heartButton.hide();
	potionButton.disabled = true;
	potionButton.hide();
	close = false;


func _on_Button_pressed():
	if PlayerStats.money >= orbCost and PlayerStats.orbInStock:
		PlayerStats.orbInStock = false;
		PlayerStats.set_obj(PlayerStats.obj + 1)
		$AudioStreamPlayer.play();
		PlayerStats.change_money(-orbCost);


func _on_HeartButton_pressed():
	if PlayerStats.money >= heartCost:
		PlayerStats.daggers += 1;
		PlayerStats.change_money(-heartCost);
		$AudioStreamPlayer.play();


func _on_SlimeButton_pressed():
	if PlayerStats.money >= potCost:
		PlayerStats.potion = true
		PlayerStats.change_money(-potCost);
		$AudioStreamPlayer.play();
