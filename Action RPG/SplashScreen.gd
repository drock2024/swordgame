extends Control

func _ready():
	Player.visible = false;
	Player.set_physics_process(false);

func _on_SplashAnimation_animation_finished(anim_name):
	get_tree().change_scene("res://UI/TitleScreen.tscn");
	#get_tree().change_scene("res://World/Levels/Hell/HellLevel.tscn");
	#get_tree().change_scene("res://UI/CharacterCards/IntroDialogueScene.tscn")
	#get_tree().change_scene("res://World/Levels/Dungeon/DungeonRoom1.tscn");
	#get_tree().change_scene("res://World/Levels/Dungeon/DungeonBoss.tscn")
	#Player.set_physics_process(true);
