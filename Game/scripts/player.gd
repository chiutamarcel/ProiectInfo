extends KinematicBody2D

const SPEED = 140

onready var projectile_scene = preload("res://scenes/areas/sword.tscn")

var movedir = Vector2(0,0)
var shootdir = Vector2(0,0)
var spriteDir = "down"
var projectileSpriteDir = "down"

func _physics_process(delta):
	controls_loop()
	movement_loop()
	spritedir_loop()
	
	if movedir != Vector2(0,0):
		anim_switch("walk")
	else:
		anim_switch("idle")
		
	if Input.is_action_just_pressed("shoot_up") :
		shoot()
	if Input.is_action_just_pressed("shoot_down") :
		shoot()
	if Input.is_action_just_pressed("shoot_right") :
		shoot()
	if Input.is_action_just_pressed("shoot_left") :
		shoot()

func controls_loop():
	#movement
	var LEFT = Input.is_action_pressed("move_left")
	var RIGHT = Input.is_action_pressed("move_right")
	var UP = Input.is_action_pressed("move_up")
	var DOWN = Input.is_action_pressed("move_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
	
	#control
	var LEFT_SHOOT = Input.is_action_just_pressed("shoot_left")
	var RIGHT_SHOOT = Input.is_action_just_pressed("shoot_right")
	var UP_SHOOT = Input.is_action_just_pressed("shoot_up")
	var DOWN_SHOOT= Input.is_action_just_pressed("shoot_down")
	
	shootdir.x = -int(LEFT_SHOOT) + int(RIGHT_SHOOT)
	shootdir.y = -int(UP_SHOOT) + int(DOWN_SHOOT)
	
func movement_loop():
	var motion = movedir.normalized() * SPEED
	move_and_slide(motion, Vector2(0,0))
	
func spritedir_loop():
	match movedir:
		Vector2(-1, 0):
			spriteDir = "left"
		Vector2(1, 0):
			spriteDir = "right"
		Vector2(0, -1):
			spriteDir = "up"
		Vector2(0, 1):
			spriteDir = "down"
			
func anim_switch(animation):
	var newanim = str(animation, "_", spriteDir)
	if $anim.current_animation != newanim:
		$anim.play(newanim)
		
func shoot():
	var projectile = projectile_scene.instance()
	get_parent().add_child(projectile)
	projectile.position = get("position")
	projectile.rotation = shootdir.angle()