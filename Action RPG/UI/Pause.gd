extends Control

var is_paused = false setget set_is_paused;

func _ready():
	PlayerStats.connect("no_health", self, "game_over");
	var font = DynamicFont.new();
	font.font_data = load ("res://UI/alagard.ttf");
	$VBoxContainer/Label.set("custom_fonts/font", font);
	$VBoxContainer/ResumeButton.set("custom_fonts/font", font);
	$VBoxContainer/QuitButton.set("custom_fonts/font", font);
	$VBoxContainer/MenuButton.set("custom_fonts/font", font);

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused;

func set_is_paused(value):
	is_paused = value;
	get_tree().paused = is_paused;
	visible = is_paused;

func game_over():
	$VBoxContainer/Label.text = "Game Over"
	$VBoxContainer/ResumeButton.queue_free();
	self.is_paused = true;

func _on_ResumeButton_pressed():
	self.is_paused = false;

func _on_QuitButton_pressed():
	get_tree().quit();


func _on_MenuButton_pressed():
	get_tree().change_scene("res://UI/TitleScreen.tscn");
	self.is_paused = false;
	PlayerStats.reset();
