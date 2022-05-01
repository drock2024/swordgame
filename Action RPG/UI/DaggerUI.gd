extends Control

var daggers = 1 setget set_daggers
var max_daggers = 3 setget set_max_daggers

onready var daggerUIFull = $DaggerUIFull;
onready var daggerUIEmpty = $DaggerUIEmpty;

onready var label = $Label

func set_daggers(value):
	daggers = clamp(value, 0, max_daggers);
	if daggerUIFull != null:
		daggerUIFull.rect_size.x = daggers * 16;
	
func set_max_daggers(value):
	max_daggers = max(value, 1);
	self.daggers = min(daggers, max_daggers);
	if daggerUIEmpty != null:
		daggerUIEmpty.rect_size.x = max_daggers * 16;
	
func _ready():
	self.max_daggers = PlayerStats.max_daggers;
	self.daggers = PlayerStats.daggers;
	PlayerStats.connect("daggers_changed", self, "set_daggers");
	PlayerStats.connect("max_daggers_changed", self, "set_max_daggers");
