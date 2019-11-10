extends KinematicBody2D

const SPEED = 140

var movedir = Vector2(0,0)
var spriteDir = "down"

func _physics_process(delta):
	controls_loop()
	movement_loop()
	spritedir_loop()
	
	if movedir != Vector2(0,0):
		anim_switch("walk")
	else:
		anim_switch("idle")

func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
	
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