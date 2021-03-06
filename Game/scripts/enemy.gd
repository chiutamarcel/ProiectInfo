extends KinematicBody2D

const SPEED = 100
const ATTACK_DISTANCE = 35
const ATTACK_CD = 1
const POINT_RADIUS = 5

onready var nav_2d : Navigation2D = get_parent().get_node("Navigation2D")
onready var player = get_parent().get_node("player")

var state = "chasing"
var attackTimer = 0
var damage = 1
var spriteDir
var path

func _ready():
	path = nav_2d.get_simple_path(position, player.position)
	
func _physics_process(delta):
	if player.velocity.length() > 0:
		_update_navigation_path(position, player)
		
	if position.distance_to(player.position) <= ATTACK_DISTANCE:
		if attackTimer >= ATTACK_CD:
			attack()
		anim_switch("idle")
	else:
		gotoplayer(delta)
		
	attackTimer += delta
	
	if $healthNode.curHealth <= 0:
		die()
		
	spritedir_loop()
	
func gotoplayer(delta):
	if path:
		var target = path[0]
		var direction = (target-position).normalized()
		
		position += direction * SPEED * delta
		
		if position.distance_to(target) <= POINT_RADIUS:
			path.remove(0)
			if path.size() == 0:
				path = null
	
func attack():
	player.get_node("healthNode").takeDamage(damage)
	attackTimer = 0
	
func anim_switch(animation):
	var newanim = str(animation, spriteDir)
	if $anim.current_animation != newanim:
		$anim.play(newanim)

func spritedir_loop():
	var direction
	if path:
		if spriteDir != null:
			anim_switch("run")
		var target = path[0]
		direction = target-position
	else:
		direction = player.position-position
		anim_switch("idle")
	
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
	
func _update_navigation_path(start_position, end_position):
	path = nav_2d.get_simple_path(position, player.position)
	if path:
		path.remove(0)

func die():
	queue_free()