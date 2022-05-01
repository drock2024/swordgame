extends Control

var orbs = 0 setget set_orbs
var max_orbs = 2 setget set_max_orbs

onready var orbUIFull = $OrbUIFull;
onready var orbUIEmpty = $OrbUIEmpty;

onready var label = $Label

func set_orbs(value):
	orbs = clamp(value, 0, max_orbs);
	if orbUIFull != null:
		orbUIFull.rect_size.x = orbs * 15;
	
func set_max_orbs(value):
	max_orbs = max(value, 1);
	self.orbs = min(orbs, max_orbs);
	if orbUIFull != null:
		orbUIEmpty.rect_size.x = max_orbs * 15;
	
func _ready():
	self.max_orbs = PlayerStats.max_obj;
	self.orbs = PlayerStats.obj;
	PlayerStats.connect("obj_changed", self, "set_orbs");
	PlayerStats.connect("max_obj_changed", self, "set_max_orbs");
