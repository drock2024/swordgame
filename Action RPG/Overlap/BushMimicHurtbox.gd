extends "res://Overlap/Hurtbox.gd"

const GrassEffect = preload("res://Effects/GrassEffect.tscn");

func create_hit_effect():
	var effect = HitEffect.instance();
	var leafEffect = GrassEffect.instance();
	var main = get_tree().current_scene;
	main.add_child(effect)
	main.add_child(leafEffect)
	effect.global_position = global_position;
	leafEffect.global_position = global_position - Vector2(8, 12);
