extends Control

var zoom_in = false
var zoom_out = false
var zoom_speed = Vector2(1.4, 1.4)
var focused
var swapping = false
var prev_focused
var og_cam_pos
var prince_button_target= false

#Second order dynamics vars
var xp = Vector2(0,0)
var y = Vector2(0,0)
var yd = Vector2(0,0)
var x = Vector2(0,0)
var xd = Vector2(0,0)
var k1 = 0
var k2 = 0
var k3 = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	og_cam_pos = $Camera2D.position
	prev_focused = $CanvasLayer/AssassinCard
	focused = $CanvasLayer/PrinceButton
	$VBoxContainer/OptionsButton.grab_focus();
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
	$WolfButton/Label.set("custom_fonts/font", labelFont);
	if PlayerStats.night_boss and PlayerStats.found_wolf:
		$WolfButton.show();
	$PlainButton/Label.hide();
	$PaladinButton/Label.hide();
	$RogueButton/Label.hide();
	$WolfButton/Label.hide();
	#Audio Settings
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -15)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), -100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), 0);
	Player.position.x = -100;
	Player.position.y = -100;
	#Player.set_physics_process(false);

func _process(delta):
#	if prince_button_target:
#		$Camera2D.position = $Camera2D.position.linear_interpolate($PrinceButton.rect_global_position + Vector2(48,32), delta * 7)
#	if zoom_in:
#		if xd == Vector2(0,0):
#			xd = (x - xp) / delta
#			xp = x
#		if $Camera2D.zoom > Vector2(0.5, 0.5):
#			#$Camera2D.set_zoom($Camera2D.zoom - (zoom_speed * delta))
#			$Camera2D.zoom = $Camera2D.zoom + delta * yd
#			yd = yd + delta * (x + k3*xd - $Camera2D.zoom - k1*yd) / k2
#			#$Camera2D.set_zoom(y)
#		else:
#			zoom_in = false
#	if zoom_out:
#		if xd == Vector2(0,0):
#			xd = (x - xp) / delta
#			xp = x
#		if $Camera2D.zoom < Vector2(1, 1):
#			#$Camera2D.set_zoom($Camera2D.zoom + (zoom_speed * delta))
#			$Camera2D.zoom = $Camera2D.zoom - delta * yd
#			yd = yd + delta * (x + k3*xd - $Camera2D.zoom - k1*yd) / k2
#			#$Camera2D.set_zoom(y)
#		else:
#			zoom_out = false
	#Card sliding
	if swapping:
		if prev_focused.position.x < 380:
			prev_focused.position.x += 10
		if focused.position.x > 260:
			focused.position.x -= 10
		else:
			swapping = false

func second_order_dynamics(f, z, r, x0):
	#compute constants
	k1 = z / (PI * f)
	k2 = 1 / ((2 * PI * f) * (2 * PI * f))
	k3 = r * z / (2 * PI * f)
	#Init vars
	xp = x0
	#$Camera2D.zoom = x0
	yd = Vector2(0,0)


func _on_QuitButton_pressed():
	get_tree().quit();


func _on_PlainButton_pressed():
	PlayerStats.player_class = "BASE"
	#get_tree().change_scene("res://SceneManager.tscn");
	get_tree().change_scene("res://UI/CharacterCards/IntroDialogueScene.tscn");
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), PlayerStats.volume)
	


func _on_RogueButton_pressed():
	PlayerStats.player_class = "ROGUE"
	get_tree().change_scene("res://UI/CharacterCards/IntroDialogueScene.tscn");
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), PlayerStats.volume)


func _on_OptionsButton_pressed():
	get_tree().change_scene("res://UI/SettingsMenu.tscn");


func _on_PrinceButton_pressed():
	PlayerStats.player_class = "PRINCE"
	get_tree().change_scene("res://UI/CharacterCards/IntroDialogueScene.tscn");
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), PlayerStats.volume)


func _on_PaladinButton_pressed():
	PlayerStats.player_class = "PALADIN"
	get_tree().change_scene("res://UI/CharacterCards/IntroDialogueScene.tscn");
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), PlayerStats.volume)

#Label showing and hiding
func _on_PlainButton_focus_entered():
	$PlainButton/Label.show();
	$Camera2D.position = $PlainButton.rect_global_position + Vector2(48,32)
	$Camera2D.set_zoom(Vector2(0.5, 0.5))
	focused = $CanvasLayer/PhilCard
	swapping = true
	$CanvasLayer/PhilCard.show()

func _on_PlainButton_focus_exited():
	$PlainButton/Label.hide();
	$ButtonSwitch.play();
	prev_focused = $CanvasLayer/PhilCard

func _on_PaladinButton_focus_entered():
	$PaladinButton/Label.show();
	$Camera2D.position = $PaladinButton.rect_global_position + Vector2(48,32)
	$Camera2D.set_zoom(Vector2(0.5, 0.5))
	focused = $CanvasLayer/PaladinCard
	swapping = true
	$CanvasLayer/PaladinCard.show()

func _on_PaladinButton_focus_exited():
	$PaladinButton/Label.hide();
	$ButtonSwitch.play();
	prev_focused = $CanvasLayer/PaladinCard

func _on_RogueButton_focus_entered():
	$RogueButton/Label.show();
	$Camera2D.set_zoom(Vector2(0.5, 0.5))
	$Camera2D.position = $RogueButton.rect_global_position + Vector2(48,32)
	focused = $CanvasLayer/AssassinCard
	swapping = true
	$CanvasLayer/AssassinCard.show()

func _on_RogueButton_focus_exited():
	$RogueButton/Label.hide();
	$ButtonSwitch.play();
	prev_focused = $CanvasLayer/AssassinCard


func _on_PrinceButton_focus_entered():
	$PrinceButton/Label.show();
	#$Camera2D.position = $PrinceButton.rect_global_position + Vector2(48,32)
	prince_button_target = true
	#second_order_dynamics(0.6, 1, 0, $Camera2D.zoom)
	var tween = $Tween
	tween.interpolate_property($Camera2D, "zoom", $Camera2D.zoom, Vector2(0.5,0.5), 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.interpolate_property($Camera2D, "position", $Camera2D.position, $PrinceButton.rect_global_position + Vector2(48,32), 0.2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
	zoom_in = true
	focused = $CanvasLayer/PrinceCard
	swapping = true
	$CanvasLayer/PrinceCard.show()


func _on_PrinceButton_focus_exited():
	$PrinceButton/Label.hide();
	$ButtonSwitch.play();
	prince_button_target = false
	prev_focused = $CanvasLayer/PrinceCard


func _on_WolfButton_pressed():
	PlayerStats.player_class = "WOLF"
	get_tree().change_scene("res://SceneManager.tscn");
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), PlayerStats.volume)


func _on_WolfButton_focus_entered():
	$WolfButton/Label.show();
	$Camera2D.position = $WolfButton.rect_global_position + Vector2(48,32)
	$Camera2D.set_zoom(Vector2(0.5, 0.5))
	focused = $CanvasLayer/WolfCard
	swapping = true


func _on_WolfButton_focus_exited():
	$WolfButton/Label.hide();
	$ButtonSwitch.play();
	prev_focused = $CanvasLayer/WolfCard
	



func _on_OptionsButton_focus_entered():
	$VBoxContainer/OptionsButton/Arrow.show()
	#$Camera2D.position = og_cam_pos
	zoom_out = true
	var tween = $Tween
	tween.interpolate_property($Camera2D, "zoom", $Camera2D.zoom, Vector2(1,1), 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.interpolate_property($Camera2D, "position", $Camera2D.position, og_cam_pos, 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
	second_order_dynamics(0.6, 1, 0, $Camera2D.zoom)
	$CanvasLayer/PrinceCard.hide()


func _on_QuitButton_focus_entered():
	$VBoxContainer/QuitButton/Arrow.show()


func _on_OptionsButton_focus_exited():
	$VBoxContainer/OptionsButton/Arrow.hide()
	$ButtonSwitch.play();


func _on_QuitButton_focus_exited():
	$VBoxContainer/QuitButton/Arrow.hide()
	$ButtonSwitch.play();
