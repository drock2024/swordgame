extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$PrinceButton.grab_focus();
	var font = DynamicFont.new();
	font.font_data = load ("res://UI/alagard.ttf");
	var labelFont = DynamicFont.new();
	labelFont.font_data = load ("res://UI/alagard.ttf");
	labelFont.size = 12;
	$VBoxContainer/OptionsButton.set("custom_fonts/font", font);
	$VBoxContainer/QuitButton.set("custom_fonts/font", font);
	$PlainButton/Label.set("custom_fonts/font", labelFont);
	$PaladinButton/Label.set("custom_fonts/font", labelFont);
	$RogueButton/Label.set("custom_fonts/font", labelFont);
	$PrinceButton/Label.set("custom_fonts/font", labelFont);
	$PlainButton/Label.hide();
	$PaladinButton/Label.hide();
	$RogueButton/Label.hide();
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -15)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), -100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), 0);
	Player.position.x = -100;
	Player.position.y = -100;


func _on_QuitButton_pressed():
	get_tree().quit();


func _on_PlainButton_pressed():
	PlayerStats.player_class = "BASE"
	get_tree().change_scene("res://SceneManager.tscn");
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), PlayerStats.volume)
	


func _on_RogueButton_pressed():
	PlayerStats.player_class = "ROGUE"
	get_tree().change_scene("res://SceneManager.tscn");
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), PlayerStats.volume)


func _on_OptionsButton_pressed():
	get_tree().change_scene("res://UI/SettingsMenu.tscn");


func _on_PrinceButton_pressed():
	PlayerStats.player_class = "PRINCE"
	get_tree().change_scene("res://SceneManager.tscn");
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), PlayerStats.volume)


func _on_PaladinButton_pressed():
	PlayerStats.player_class = "PALADIN"
	get_tree().change_scene("res://SceneManager.tscn");
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), PlayerStats.volume)

#Label showing and hiding
func _on_PlainButton_focus_entered():
	$PlainButton/Label.show();

func _on_PlainButton_focus_exited():
	$PlainButton/Label.hide();

func _on_PaladinButton_focus_entered():
	$PaladinButton/Label.show();

func _on_PaladinButton_focus_exited():
	$PaladinButton/Label.hide();

func _on_RogueButton_focus_entered():
	$RogueButton/Label.show();

func _on_RogueButton_focus_exited():
	$RogueButton/Label.hide();


func _on_PrinceButton_focus_entered():
	$PrinceButton/Label.show();


func _on_PrinceButton_focus_exited():
	$PrinceButton/Label.hide();
