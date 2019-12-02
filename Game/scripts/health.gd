extends Node

var curHealth
export var maxHealth = 6

func _ready():
	curHealth = maxHealth

func takeDamage(damage):
	curHealth -= damage
	
func heal(healAmount):
	curHealth += healAmount