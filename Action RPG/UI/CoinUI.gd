extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var labelFont = DynamicFont.new();
	labelFont.font_data = load ("res://UI/alagard.ttf");
	labelFont.size = 12;
	$Label.set("custom_fonts/font", labelFont);
	$Label.text = str(PlayerStats.money);
	PlayerStats.connect("money_changed", self, "set_text");

func set_text(value):
	$Label.text = str(value);
