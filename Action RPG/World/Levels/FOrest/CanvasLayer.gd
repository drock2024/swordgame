extends CanvasLayer

var label_vis = 0.0;
var label_flag = false;

func _ready():
	var font = DynamicFont.new();
	font.font_data = load ("res://UI/alagard.ttf");
	font.size = 20;
	$BossName.set("custom_fonts/font", font);
	
func _process(delta):
	$BossName.set_percent_visible(label_vis)
	if PlayerStats.time_of_day == "night":
		$BossName.text = "Daytime Rabbit";
	if label_vis < 1 and PlayerStats.bat_summoned and label_flag == false:
		label_vis += .01;
	if label_vis >= 1 and label_flag == false:
		$NameTimer.start(3)
		label_flag = true
	if PlayerStats.bat_defeated:
		$BossName.hide();
func _on_NameTimer_timeout():
	label_vis -= 0.05;
	$NameTimer.stop();
	$BossName.hide();
