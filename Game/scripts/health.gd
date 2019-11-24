extends Node

var curHealth = 5
var maxHealth = 6

func takeDamage(damage):
	curHealth -= damage
	
func heal(healAmount):
	curHealth += healAmount