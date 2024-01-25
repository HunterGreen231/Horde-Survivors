extends CharacterBody2D

# Player properties
var speed: int = 200

# Animation nodes
@onready var mageAnim = get_node("MageAnimationPlayer")
@onready var mageAnimSprite = get_node("PlayerMageAnimSprite")

func _ready():
	pass

func _process(delta):
	velocity = Vector2()  # Reset velocity

	# Input handling for movement
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
		set_sprite_flip(false)
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
		set_sprite_flip(true)
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1

	# Check if the player is moving
	if velocity.length() > 0:
		mageAnim.play("Run")
	else:
		mageAnim.play("Idle")

	velocity = velocity.normalized() * speed

	# Move the player
	move_and_slide()

# Function to flip the sprite
func set_sprite_flip(is_flipped: bool):
	mageAnimSprite.flip_h = is_flipped
