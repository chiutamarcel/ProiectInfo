extends Area2D

const SPEED = 200

var damage = 1

func _physics_process(delta):
	move_local_x(SPEED * delta)



func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		body.get_node("healthNode").takeDamage(damage)
