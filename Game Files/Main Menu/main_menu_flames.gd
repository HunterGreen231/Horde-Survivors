extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Entered")
	get_node("AnimatedSprite2D").play("default")
