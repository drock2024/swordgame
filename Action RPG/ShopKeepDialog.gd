extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	var font = DynamicFont.new();
	font.font_data = load ("res://UI/alagard.ttf");
