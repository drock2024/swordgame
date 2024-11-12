extends Node2D

onready var playerDetectionZone = $PlayerDetectionZone
onready var orbButton = $CanvasLayer/VBoxContainer/Button;
onready var heartButton = $CanvasLayer/VBoxContainer/HeartButton;
onready var potionButton = $CanvasLayer/VBoxContainer/SlimeButton;
onready var keeper = $CanvasLayer/Keeper
onready var dialog = $CanvasLayer/ShopKeepDialog
onready var rect = $CanvasLayer/ColorRect;
onready var board = $CanvasLayer/Board;
onready var exitButton = $CanvasLayer/VBoxContainer/ExitButton;

var is_paused = false setget set_is_paused;

var orbCost = 10;
var heartCost = 4;
var potCost = 1;
var close = false;

func _ready():
	exitButton.grab_focus();
	var font = DynamicFont.new();
	font.font_data = load ("res://UI/alagard.ttf");
	font.size = 11;
	orbButton.set("custom_fonts/font", font);
	heartButton.set("custom_fonts/font", font);
	potionButton.set("custom_fonts/font", font);
	exitButton.set("custom_fonts/font", font);
	$HitEnter.set("custom_fonts/font", font);
	orbButton.disabled = true;
	heartButton.disabled = true;
	heartButton.hide();
	orbButton.hide();
	potionButton.disabled = true;
	potionButton.hide();
	exitButton.disabled = true;
	exitButton.hide();
	keeper.hide()
	dialog.hide()
	rect.hide()
	board.hide()

#func _process(delta):
#	if close and Input.is_action_just_pressed("ui_accept"):
#		self.is_paused = !is_paused;
#		if PlayerStats.area == "Forest":
#			if orbButton.disabled:
#				orbButton.disabled = false;
#				heartButton.disabled = false;
#				orbButton.grab_focus();
#				orbButton.show();
#				heartButton.show();
#		elif PlayerStats.area == "Dungeon":
#			if heartButton.disabled:
#				heartButton.disabled = false;
#				heartButton.grab_focus();
#				heartButton.show();
#				potionButton.disabled = false;
#				potionButton.show();

func _unhandled_input(event):
	if close && event.is_action_pressed("ui_accept") && !self.is_paused:
		self.is_paused =true;

func set_is_paused(value):
	is_paused = value;
	get_tree().paused = is_paused;
	exitButton.grab_focus();
	$BgMusic.playing = !$BgMusic.playing;
	keeper.visible = !keeper.visible;
	dialog.visible = !dialog.visible;
	rect.visible = !rect.visible;
	board.visible = !board.visible;
	exitButton.visible = !exitButton.visible;
	exitButton.disabled = !exitButton.disabled;
	if PlayerStats.area == "Forest":
		orbButton.disabled = !orbButton.disabled;
		heartButton.disabled = !heartButton.disabled;
		orbButton.visible = !orbButton.visible;
		heartButton.visible = !heartButton.visible;
	elif PlayerStats.area == "Dungeon":
		heartButton.disabled = !heartButton.disabled;
		heartButton.visible = !heartButton.visible;
		potionButton.disabled = !potionButton.disabled;
		potionButton.visible = !potionButton.visible;

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


func _on_ExitButton_pressed():
	self.is_paused = false;
