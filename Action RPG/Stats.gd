extends Node

export(int) var max_health = 1 setget set_max_health;
export(int) var max_obj = 2 setget set_max_obj;
export(int) var max_daggers = 3 setget set_max_daggers;
var health = max_health setget set_health;
var obj = 2 setget set_obj;
var daggers = 1 setget set_daggers;
var player_class = "BASE";
var volume = -30;
var fullscreen = false;
var time_of_day = "night";
var money = 0;
var bat_summoned = false;
var bat_defeated = false;
var night_boss = false;
var found_wolf = false;
var orbInStock = true;
var area = "Forest"
var player_speed = 1
var red_slime = false
var green_slime = false
var blue_slime = false
var potion = false
var prize = ""
var prizeDialog = false
var oldManDefeated = false;

#Enemy persistence variables
#Mimics
var first_mimic_defeated = false setget set_mimic;
var second_mimic_defeated = false;
var forest_mimic_defeated = false;
#Acorns
var trigger_acorn_defeated = false;
var forest_acorn_1 = false;
var forest_acorn_2 = false;
var forest_acorn_3 = false;
var mouse_pos;
var cursor_velocity = Vector2.ZERO

signal no_health
signal health_changed(value)
signal obj_changed(value);
signal daggers_changed(value);
signal health_increase();
signal money_changed(value);

#check if inside old man's room
var old_boss = false;

func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = event.position

func set_max_health(value):
	max_health = value;
	self.health = min(health, max_health);
	emit_signal("max_health_changed", max_health);
	
func set_max_obj(value):
	max_obj = value;
	self.obj = min(obj, max_obj);
	emit_signal("max_obj_changed", max_obj);

func set_max_daggers(value):
	max_daggers = value;
	self.daggers = min(daggers, max_daggers);
	emit_signal("max_daggers_changed", max_daggers);

func set_health(value):
	health = value;
	emit_signal("health_changed", health);
	if health <= 0:
		emit_signal("no_health");
		Player.healable = false;

func set_obj(value):
	obj = value;
	emit_signal("obj_changed", obj);

func increase_health():
	emit_signal("health_increase");

func set_daggers(value):
	daggers = value;
	emit_signal("daggers_changed", daggers);

func set_mimic(value):
	first_mimic_defeated = value;

func change_money(value):
	money += value;
	emit_signal("money_changed", money);

func _ready():
	self.health = max_health;

func reset():
	#Enemy variables
	health = max_health
	first_mimic_defeated = false;
	second_mimic_defeated = false;
	forest_mimic_defeated = false;
	trigger_acorn_defeated = false;
	forest_acorn_1 = false;
	forest_acorn_2 = false;
	forest_acorn_3 = false;
	bat_summoned = false;
	bat_defeated = false;
	oldManDefeated = false;
	orbInStock = true;
	obj = 0;
	daggers = 1;
	player_class = "";
	money = 0;
	time_of_day = "day";
	Camera2d.color.hide();

