extends Control

func _ready():
	randomize();
	#Disable player temp
	Player.visible = false;
	Player.set_physics_process(false);
	#Setting font data
	var font = DynamicFont.new();
	var buttonFont = DynamicFont.new();
	font.font_data = load ("res://UI/alagard.ttf");
	buttonFont.font_data = load ("res://UI/alagard.ttf");
	font.size = 16;
	buttonFont.size = 12;
	$Label.set("custom_fonts/font", font);
	$Button.set("custom_fonts/font", buttonFont);
	#Add random night/day chance
	var night_sky = preload("res://UI/PixelSkies/nightsky.png");
	var timeDict = OS.get_time();
	var hour = timeDict.hour;
	if hour >= 19:
		$Sprite.set_texture(night_sky);
		$Sprite2.set_texture(night_sky);
	
func _process(delta):
	$Sprite.position.x -= 5 * delta;
	$Sprite2.position.x -= 5 * delta;
	if $Sprite.position.x <= -160:
		$Sprite.position.x = 480;
	if $Sprite2.position.x <= -160:
		$Sprite2.position.x = 480;

func _on_Button_pressed():
	get_tree().change_scene("res://Menu.tscn");
	Player.set_physics_process(true);
