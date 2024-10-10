extends Camera2D

onready var topLeft = $Limits/TopLeft;
onready var bottomRight = $Limits/BottomRight;
onready var color = $CanvasLayer/ColorRect;
onready var shakeTimer = $Timer;
onready var tween = $Tween;

var shake_amount = 0;
var default_offset = offset;
var menu_cam = true;
var zooming = false
var smooth_zoom = 1
var target_zoom = 1
var zoom_speed = 10

func _ready():
	limit_top = topLeft.position.y;
	limit_left = topLeft.position.x;
	limit_bottom = bottomRight.position.y;
	limit_right = bottomRight.position.x;
	color.hide();
	if get_tree().current_scene.name != "res://Menu.tscn":
		set_process(false);
		menu_cam = false

func _process(delta):
	if menu_cam == false:
		offset = Vector2(rand_range(-shake_amount, shake_amount), rand_range(shake_amount, -shake_amount)) * delta + default_offset;
	
	
func shake(new_shake, shake_time=0.4, shake_limit=100):
	shake_amount += new_shake;
	if shake_amount > shake_limit:
		shake_amount = shake_limit;
	
	shakeTimer.wait_time = shake_time;
	
	tween.stop_all();
	set_process(true);
	shakeTimer.start();

func _on_Timer_timeout():
	shake_amount = 0;
	set_process(false);
	tween.interpolate_property(self, "offset", offset, default_offset,
	0.1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT);
	tween.start();
