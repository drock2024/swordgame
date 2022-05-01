extends Control

var mouse_in_slider := false;

# Called when the node enters the scene tree for the first time.
func _ready():
	var font = DynamicFont.new();
	font.font_data = load ("res://UI/alagard.ttf");
	$MainMenu.set("custom_fonts/font", font);
	$BackToGame.set("custom_fonts/font", font);
	$Quit.set("custom_fonts/font", font);
	$VBoxContainer/MasterVolume.set("custom_fonts/font", font);
	$VBoxContainer/Fullscreen.set("custom_fonts/font", font);

func _input(event):
	if(mouse_in_slider && Input.is_mouse_button_pressed(BUTTON_LEFT)):
		setValue($VolumeSlider)

func setValue(slider: TextureProgress):
	slider.ratio = ratio_in_body(slider)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), slider.value)
	PlayerStats.volume = slider.value;
	print(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")));
	

func ratio_in_body(slider: TextureProgress):
	var posClicked = get_local_mouse_position() - slider.rect_position
	var ratio = posClicked.x / slider.rect_size.x;
	if(ratio > 1.0):
		ratio = 1.0;
	elif(ratio < 0.0):
		ratio = 0.0;
	return ratio;

func _on_VolumeSlider_mouse_entered():
	mouse_in_slider = true;

func _on_VolumeSlider_mouse_exited():
	mouse_in_slider = false;


func _on_EnableFullscreen_toggled(button_pressed):
	OS.window_fullscreen = !OS.window_fullscreen;
	PlayerStats.fullscreen = !PlayerStats.fullscreen;

func _on_MainMenu_pressed():
	get_tree().change_scene("res://Menu.tscn");

func _on_Quit_pressed():
	get_tree().quit();

func _on_BackToGame_pressed():
	get_tree().change_scene("")
