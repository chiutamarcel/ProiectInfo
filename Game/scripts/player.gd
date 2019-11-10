extends KinematicBody2D

const SPEED = 140

var movedDir = Vector2(0,0)

func _physics_process(delta):
	controls_loop()
	movement_loop()

func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	movedDir.x = -int(LEFT) + int(RIGHT)
	movedDir.y = -int(UP) + int(DOWN)
	
func movement_loop():
	var motion = movedDir.normalized() * SPEED
	move_and_slide(motion, Vector2(0,0))