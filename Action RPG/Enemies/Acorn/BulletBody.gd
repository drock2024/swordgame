extends KinematicBody2D

var dir = Vector2(0, 0);
var speed = 120;

func _ready():
	if PlayerStats.time_of_day == "night" and PlayerStats.bat_summoned == true:
		$Sprite.hide();
		$CarrotSprite.show();
	if PlayerStats.area == "Hell":
		$Sprite.hide();
		$Fireball.show();
		$FireballNoise.play()
		$FireballParticles.show()
		$FireballParticles.set_velocity(speed)
		$FireballParticles.rotation = (-dir).angle();

func _physics_process(delta):
	move_and_slide(dir * speed);
	
	if PlayerStats.area != "Hell":
		var deg_per_sec = 720.0;
		rotate(delta * deg2rad(deg_per_sec));
	else:
		rotation = dir.angle();


#func _on_Hitbox_body_entered(body):
	#dir = -dir;
	#print("bruh");
