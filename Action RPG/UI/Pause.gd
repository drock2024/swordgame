extends Control

var pause_flag;

func _ready():
	var font = DynamicFont.new();
	font.font_data = load ("res://UI/alagard.ttf");
	var labelFont = DynamicFont.new();
	labelFont.font_data = load ("res://UI/alagard.ttf");
	$Label.set("custom_fonts/font", font);

func _input(event):
	if event.is_action_pressed("pause"):
		if !pause_flag:
			show();
			get_tree().paused = true;
			pause_flag = true;
		else:
			hide();
			pause_flag = false;
			get_tree().paused = false;
