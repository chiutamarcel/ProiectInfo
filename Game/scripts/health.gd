extends Node

var curHealth = 4
var maxHealth = 4

func takeDamage(damage):
	curHealth -= damage
	
func heal(healAmount):
	curHealth += healAmount