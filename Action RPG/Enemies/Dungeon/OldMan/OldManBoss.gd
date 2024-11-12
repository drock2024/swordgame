extends Node2D

onready var SwordSummon = preload("res://Enemies/Dungeon/OldMan/OldManSwords.tscn");
onready var SwordBullet = preload("res://Enemies/Dungeon/OldMan/SwordBullet.tscn");
onready var FireTrap = preload("res://Enemies/Dungeon/OldMan/OldManFire.tscn");
#onready var swords = SwordSummon.instance();
#onready var swordbullet = SwordBullet.instance();
onready var player = find_parent("DungeonBoss").get_child(4).find_node("Player")
onready var Spitter = preload("res://Enemies/Dungeon/Spitter/Spitter.tscn")
onready var deathEffect = preload("res://Effects/OldManDeathEffect.tscn");

onready var shuffle_button = get_node("CanvasLayer/Button")
onready var shuffle_card = get_node("CanvasLayer/ShuffleCard")
onready var phase_card = get_node("CanvasLayer/PhaseCard")
onready var shield = get_node("Shield")
onready var hurtBox = $Hurtbox
onready var stats = $Stats

var active = false
var phase = "spitters"
var phase_list = ["fire", "swords", "spitters"]
var flame_limit = 5 
var flame_counter = 1
var fire_sort
var spitter_limit = 8
var spitter_count = 1
var fire_trap
var pos_list = [Vector2(32, 124), Vector2(162, 75), Vector2(292, 124), Vector2(162, 216)]
var loop_tracker = 0
var card_rads = 0
var total_rads = 0
var rotate_more = true
var init = true
var target_pos = null
var between = false

func _ready():
	randomize()
	var font = DynamicFont.new();
	font.font_data = load ("res://UI/alagard.ttf");
	$CanvasLayer/Button.set("custom_fonts/font", font); 
	print(player.name)
	
func swordPhase():
	var swords = SwordSummon.instance();
	add_child(swords);
	swords.global_position = (player.global_position);
	$SwordTimer.start(27)

func firePhase():
	fire_sort = YSort.new()
	add_child(fire_sort)
	fire_sort.global_position = Vector2(160, 64)
	fire_trap = FireTrap.instance()
	fire_sort.add_child(fire_trap);
	if fire_trap.spawnDir == 0:
		fire_trap.global_position = player.global_position + Vector2(-48, 0)
#		if fire_trap.spawnDir == 45:
#			fire_trap.global_position = player.global_position + Vector2(-24, 24)
	if fire_trap.spawnDir == 90:
		fire_trap.global_position = player.global_position + Vector2(0, 48)
#		if fire_trap.spawnDir == 135:
#			fire_trap.global_position = player.global_position + Vector2(24, 24)
	if fire_trap.spawnDir == 180:
		fire_trap.global_position = player.global_position + Vector2(48, 0)
#		if fire_trap.spawnDir == 225:
#			fire_trap.global_position = player.global_position + Vector2(24, -24)
	if fire_trap.spawnDir == 270:
		fire_trap.global_position = player.global_position + Vector2(0, -48)
	$FlameTimer.start(5)
	
func spitterPhase():
	$SpitterTimer.start(1)

func beginPhases():
	active = true
	if phase == "fire":
		firePhase()
	if phase == "swords":
		swordPhase()
	if phase == "spitters":
		spitterPhase()

func finishPhase():
	active = false
	shield.visible = false
	shield.set_collision_layer_bit(0, false)
	$CooldownTimer.start(3)

func _physics_process(delta):
	#shield rotation
	shield.rotate(0.05)
	if rotate_more:
		shuffle_card.rotate(card_rads)
	total_rads += card_rads
	if total_rads > (PI * 3):
		card_rads = 0
		shuffle_card.rotation = 0
		rotate_more = false
		if phase_card.position.distance_to($CardTarget.position) > 5:
			phase_card.position.x += 4
		else:
			if init:
				init = false
				$PhaseTimer.start(1)
	if between && not(target_pos == null):
		if position.distance_to(target_pos) > 16:
			var vel = position.direction_to(target_pos) * 4
			position += vel
		else:
			target_pos == null
			startNextPhase()
	

func _on_FlameTimer_timeout():
	if flame_counter >= flame_limit:
		$FlameTimer.stop()
		fire_sort.queue_free()
		finishPhase()
	flame_counter += 1
	var fire_trap = FireTrap.instance();
	fire_sort.add_child(fire_trap);
	fire_trap.global_position = player.global_position
	


func _on_SpitterTimer_timeout():
	var spitter_x = rand_range(64, 216)
	var spitter_y = rand_range(80, 180)
	if spitter_count < spitter_limit:
		$SpitterTimer.stop()
		var spitter = Spitter.instance()
		$SpitterSort.add_child(spitter)
		spitter.global_position = Vector2(spitter_x, spitter_y)
		$SpitterTimer.start(2)
		spitter_count += 1
	else:
		$SpitterTimer.stop()
		finishPhase()


func _on_Button_pressed():
	randomize()
	phase_list.shuffle()
	phase = phase_list[0]
	if phase == "swords":
		phase_card.texture = load("res://Enemies/Dungeon/OldMan/SwordCard.png")
	if phase == "spitters":
		phase_card.texture = load("res://Enemies/Dungeon/OldMan/SlimeCard.png")
	if phase == "fire":
		phase_card.texture = load("res://Enemies/Dungeon/OldMan/FireCard.png")
	shuffle_button.disabled = true
	shuffle_button.visible = false
	card_rads = 0.15
	between = false
	#beginPhases()

func _on_SwordTimer_timeout():
	$SwordTimer.stop()
	finishPhase()


func _on_PhaseTimer_timeout():
	$PhaseTimer.stop()
	beginPhases()
	total_rads = 0
	card_rads = 0
	rotate_more = true
	phase_card.position = Vector2(-19, 111)
	init = true
	
	


func _on_CooldownTimer_timeout():
	$CooldownTimer.stop()
	if loop_tracker < 3:
		loop_tracker += 1
	else:
		loop_tracker = 0
	target_pos = pos_list[loop_tracker]
	between = true

func startNextPhase():
	spitter_count = 1
	if between == true:
		shield.visible = true
		shield.set_collision_layer_bit(0, true)
		shuffle_button.disabled = false
		shuffle_button.visible = true


func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage;
	hurtBox.create_hit_effect();
	hurtBox.start_invincibility(3.0)


func _on_Stats_no_health():
	var death = deathEffect.instance()
	get_parent().add_child(death);
	death.global_position = global_position
	queue_free()
	
