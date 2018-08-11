extends KinematicBody2D

var speed = 300
var movedir = Vector2()
onready var screensize = get_viewport_rect().size
var time = 0
var timetext
var health = 3
var invincible = false

func _ready():
	time = 53
	timetext = "53"
	health = 5
	invincible = false

func _physics_process(delta):
	movedir = move_and_slide(movedir)
	movedir.y = 800
	$HUD/Control/Timeleft.text = timetext
	
	var target_speed = 0
	
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		target_speed += 1
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		target_speed += -1
	
	movedir.x = target_speed * speed
	position.x = clamp(position.x, 0, screensize.x)
	
	if health == 0:
		get_tree().reload_current_scene()

func _on_CountDown_timeout():
	$CountDown.start()
	time -= 1
	timetext = str(time)
	if time < 0:
		time = 0

func damage():
	if invincible == false:
		health -= 1
		invincible = true
		$Invinc.start()

func _on_Invinc_timeout():
	invincible = false
