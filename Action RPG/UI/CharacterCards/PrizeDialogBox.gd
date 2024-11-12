extends ColorRect

export var dialogPath = "res://json/NoPrizeDialog.json";
export(float) var textSpeed = 0.05;

var dialog;

var phraseNum = 0;
var finished = false;
var top_right = true;


signal text_finished

func _ready():
	var labelFont = DynamicFont.new();
	labelFont.font_data = load ("res://UI/alagard.ttf");
	labelFont.size = 12;
	$Name.add_font_override("normal_font", labelFont);
	$Text.add_font_override("normal_font", labelFont);
	
	$Timer.wait_time = textSpeed;
	if PlayerStats.prize == "coin":
		dialogPath = "res://json/CoinPrizeDialog.json"
	if PlayerStats.prize == "heart":
		dialogPath = "res://json/HealthPrizeDialog.json"
	if PlayerStats.prize == "ability":
		dialogPath = "res://json/AbilityPrizeDialog.json"
	dialog = getDialog();
	assert(dialog, "Dialog not found");
	nextPhrase();

func _process(delta):
	$Indicator.visible = finished;
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase();
		else:
			$Text.visible_characters = len($Text.text);

func getDialog() -> Array:
	var f = File.new();
	assert(f.file_exists(dialogPath), "File path does not exist");
	
	f.open(dialogPath, File.READ);
	var json = f.get_as_text();
	
	var output = parse_json(json);
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return [];

func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		emit_signal("text_finished")
		phraseNum = 0;
		visible = false;
		get_tree().change_scene("res://World/Levels/Dungeon/DungeonRoom1.tscn");
		return;
		
	finished = false;
	
	$Name.bbcode_text = dialog[phraseNum]["Name"];
	$Text.bbcode_text = dialog[phraseNum]["Text"];
	
	$Text.visible_characters = 0;
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1;
		
		$Timer.start();
		yield($Timer, "timeout");
	
	finished = true;
	phraseNum += 1
	return;
