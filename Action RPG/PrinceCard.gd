extends Node2D

func _ready():
	var labelFont = DynamicFont.new();
	labelFont.font_data = load ("res://UI/alagard.ttf");
	labelFont.size = 12;
	$Label.set("custom_fonts/font", labelFont)
