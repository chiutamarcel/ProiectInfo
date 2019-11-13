extends KinematicBody2D

const SPEED = 100
const ATTACK_DISTANCE = 35
const ATTACK_CD = 1

var direction
var distance
var velocity = Vector2(0,0)
var state = "chasing"
var attackTimer = 0
var damage = 1
var spriteDir

func _ready():
	pass
	
func _physics_process(delta):
	findplayer()
	spritedir_loop()
	if distance <= ATTACK_DISTANCE:
		if attackTimer >= ATTACK_CD:
			attack()
		anim_switch("idle")
	else:
		gotoplayer(delta)
		anim_switch("run")
		
	attackTimer += delta
	
	if $healthNode.curHealth <= 0:
		die()
		
func gotoplayer(delta):
	velocity = direction * SPEED * delta
	move_and_slide(velocity)
	
func findplayer():
	direction = get_parent().get_node("player").get("position") - get("position")
	distance = sqrt(direction.x*direction.x + direction.y*direction.y)
	
func attack():
	get_parent().get_node("player").get_node("healthNode").takeDamage(damage)
	attackTimer = 0
	
func anim_switch(animation):
	var newanim = str(animation, "_", spriteDir)
	if $anim.current_animation != newanim:
		$anim.play(newanim)

func spritedir_loop():
	if abs(direction.x) <= abs(direction.y):
		if direction.y < 0:
			spriteDir = "up"
		if direction.y > 0:
			spriteDir = "down"
	else :
		if direction.x < 0:
			spriteDir = "left"
		if direction.x > 0:
			spriteDir = "right"
	

func die():
	queue_free()