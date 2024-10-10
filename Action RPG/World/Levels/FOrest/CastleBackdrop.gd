extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.hide();
	$Day.hide();
	$Night.hide();
	Camera2d.color.hide();
	if PlayerStats.time_of_day == "day":
		$Day.show();
	else:
		$Night.show();
	var font = DynamicFont.new();
	font.font_data = load ("res://UI/alagard.ttf");
	font.size = 12;
	$Label.set("custom_fonts/font", font);
	
func _process(delta):
	var position = Vector2(0, 20 * delta);
	$Camera2D.position -= position;
	
	if $Camera2D.position.y >= $Camera2D/Limits/TopLeft.position.y + 50:
		$Timer.start(0.25);


func _on_Timer_timeout():
	$Label.show();
	$Timer2.start(3);
	$Timer.stop();

func _on_Timer2_timeout():
	PlayerStats.area = "Dungeon"
	get_tree().change_scene("res://World/Levels/Dungeon/DungeonRoom1.tscn");
	#PlayerStats.reset();
