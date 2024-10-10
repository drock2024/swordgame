extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var font = DynamicFont.new();
	font.font_data = load ("res://UI/alagard.ttf");
	$BetLow.set("custom_fonts/font", font);
	$BetHigh.set("custom_fonts/font", font);

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ColorRect_text_finished():
	if PlayerStats.area == "Dungeon" && PlayerStats.potion:
		$BetLow.show()
		$BetHigh.show()
		$BetLow.grab_focus()


func _on_BetLow_pressed():
	PlayerStats.health = 4;
	get_tree().change_scene("res://World/Levels/Dungeon/DungeonBoss.tscn")


func _on_BetHigh_pressed():
	PlayerStats.health = 1
	get_tree().change_scene("res://World/Levels/Dungeon/DungeonBoss.tscn")
