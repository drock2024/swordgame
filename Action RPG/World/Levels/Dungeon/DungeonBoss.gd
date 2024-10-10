extends "res://World/Levels/Dungeon/DungeonRoom1.gd"

func _ready():
	PlayerStats.old_boss = true;
	$AudioStreamPlayer.play();
