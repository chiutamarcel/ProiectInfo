extends Area2D

const SPEED = 200

func _physics_process(delta):
	move_local_x(SPEED * delta)
	