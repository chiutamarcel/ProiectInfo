extends Node

var curHealth
export var maxHealth = 6

onready var effect = get_parent().get_node("effect")
onready var sprite = get_parent().get_node("Sprite")

func _ready():
	curHealth = maxHealth

func takeDamage(damage):
	curHealth -= damage
	effect.start()
	effect.interpolate_property(sprite, "self_modulate", 
								Color.white, Color.red, 
								0.2, Tween.TRANS_SINE, Tween.EASE_IN)
	effect.interpolate_property(sprite, "self_modulate", 
								Color.red, Color.white, 
								0.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	
func heal(healAmount):
	curHealth += healAmount