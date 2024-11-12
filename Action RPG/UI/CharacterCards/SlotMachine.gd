extends AnimatedSprite

var prizes = ["coin", "heart", "ability"]
var prize1 = ""
var prize2 = ""
var prize3 = ""


func _ready():
	randomize()
	$Button.grab_focus()
	var font = DynamicFont.new();
	font.font_data = load ("res://UI/alagard.ttf");
	font.size = 12;
	$Button.set("custom_fonts/font", font)
	#weight outcomes based on player actions
	if PlayerStats.first_mimic_defeated && PlayerStats.second_mimic_defeated && PlayerStats.forest_mimic_defeated:
		prizes = ["coin", "heart", "ability", "ability"];
	if PlayerStats.money >= 10:
		prizes = ["coin", "heart", "ability", "coin"];
	if PlayerStats.health >= 4:
		prizes = ["coin", "heart", "ability", "heart"];


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	play("click")
	$Slot1.play("shuffle")
	$Slot2.play("shuffle")
	$Slot3.play("shuffle")
	$Timer.start(1)
	$Button.hide()


func _on_Timer_timeout():
	prizes.shuffle()
	$Timer.stop()
	$Timer2.start(1)
	play("default")
	$Slot1.play(prizes[0])
	prize1 = prizes[0]

func _on_Timer2_timeout():
	prizes.shuffle()
	$Timer2.stop()
	$Timer3.start(1)
	$Slot2.play(prizes[0])
	prize2 = prizes[0]

func _on_Timer3_timeout():
	prizes.shuffle()
	$Timer3.stop()
	$Slot3.play(prizes[0])
	prize3 = prizes[0]
	checkPrizes()

func checkPrizes():
	PlayerStats.prizeDialog = true
	if prize1 == prize2 and prize2 == prize3:
		if prize1 == "coin":
			PlayerStats.money += 5
			PlayerStats.prize = "coin"
		if prize1 == "heart":
			PlayerStats.max_health += 1
			PlayerStats.prize = "heart"
		if prize1 == "ability":
			PlayerStats.prize = "ability"
			Player.invis_length += 1
			Player.prince_length += 1
