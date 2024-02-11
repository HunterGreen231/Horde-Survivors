extends CharacterBody2D

# Enemy properties
var speed: int = 60
var isPursuing: bool = true
var playerMage: Node2D
@onready var skeletonAnimatedSprite = get_node("SkeletonAnimatedSprite")


func _ready():
	# Assuming the player node is named "Player"
	playerMage = get_node("../../Player/PlayerMage")
	skeletonAnimatedSprite.play("Run")
	

func _process(delta):
	var direction = (playerMage.global_position - global_position).normalized()
	skeletonAnimatedSprite.flip_h = direction.x < 0
	
	if(isPursuing):
		pursue_player(direction)
	else:
		velocity = Vector2(0,0)

func pursue_player(direction):
	velocity = direction * speed
	move_and_slide()

func _on_skeleton_area_body_entered(body):
	if (body.name == "PlayerMage"):
		isPursuing = false
		body.take_damage()

func _on_skeleton_area_body_exited(body):
	if (body.name == "PlayerMage"):
		$PursuitDelay.start()

func _on_pursuit_delay_timeout():
	isPursuing = true
