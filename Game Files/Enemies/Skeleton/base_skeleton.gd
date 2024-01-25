extends CharacterBody2D

# Enemy properties
var speed: int = 60
var playerMage: Node2D
@onready var skeletonAnimatedSprite = get_node("SkeletonAnimatedSprite")

func _ready():
	# Assuming the player node is named "Player"
	playerMage = get_node("../../Player/PlayerMage")
	skeletonAnimatedSprite.play("Run")
	

func _process(delta):
	var direction = (playerMage.global_position - global_position).normalized()
	
	skeletonAnimatedSprite.flip_h = direction.x < 0
	
	# Update the inherent velocity property
	velocity = direction * speed

	# Call move_and_slide without any arguments
	move_and_slide()
