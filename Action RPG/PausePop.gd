extends Popup

var pause_flag = false;

func _input(event):
	if event.is_action_pressed("pause"):
		if !pause_flag:
			popup_centered(Vector2(128, 128));
			show();
			get_tree().paused = true;
			pause_flag = true;
		else:
			hide();
			pause_flag = false;
			get_tree().paused = false;
