extends Node2D

onready var playerDetectionZone = $PlayerDetectionZone
onready var orbButton = $VBoxContainer/Button;
onready var heartButton = $VBoxContainer/HeartButton;

var orbCost = 10;
var heartCost = 4;
var orbInStock = true;

func _ready():
	orbButton.grab_focus();
	var font = DynamicFont.new();
	font.font_data = load ("res://UI/alagard.ttf");
	font.size = 11;
	orbButton.set("custom_fonts/font", font);
	heartButton.set("custom_fonts/font", font);
	orbButton.disabled = true;
	heartButton.disabled = true;
	heartButton.hide();
	orbButton.hide();

func _on_PlayerDetectionZone_body_entered(body):
	orbButton.disabled = false;
	heartButton.disabled = false;
	orbButton.grab_focus();
	orbButton.show();
	heartButton.show();


func _on_PlayerDetectionZone_body_exited(body):
	orbButton.disabled = true;
	orbButton.hide();
	heartButton.disabled = true;
	heartButton.hide();


func _on_Button_pressed():
	if PlayerStats.money >= orbCost and orbInStock:
		orbInStock = false;
		PlayerStats.set_obj(PlayerStats.obj + 1)
		PlayerStats.money -= orbCost;


func _on_HeartButton_pressed():
	if PlayerStats.money >= heartCost:
		PlayerStats.daggers += 1;
		PlayerStats.money -= heartCost;
