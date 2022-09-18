extends Node

export(int) var max_health = 1 setget set_max_health;
export(int) var max_obj = 2 setget set_max_obj;
export(int) var max_daggers = 3 setget set_max_daggers;
var health = max_health setget set_health;
var obj = 0 setget set_obj;
var daggers = 1 setget set_daggers;
var player_class = "";
var volume = -30;
var fullscreen = false;
var time_of_day = "night";
var mimic_defeated = false setget set_mimic;
var money = 0;
var bat_summoned = false;
var bat_defeated = false;

signal no_health
signal health_changed(value)
signal obj_changed(value);
signal daggers_changed(value);
signal health_increase();

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

func set_obj(value):
	obj = value;
	emit_signal("obj_changed", obj);

func increase_health():
	emit_signal("health_increase");

func set_daggers(value):
	daggers = value;
	emit_signal("daggers_changed", daggers);

func set_mimic(value):
	mimic_defeated = value;

func _ready():
	self.health = max_health;

