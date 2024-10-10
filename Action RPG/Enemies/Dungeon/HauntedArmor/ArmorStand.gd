extends Node2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn");

func _on_Hurtbox_area_entered(area):
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance();
	get_parent().add_child(enemyDeathEffect);
	enemyDeathEffect.global_position = Vector2(global_position.x, global_position.y + 32);
