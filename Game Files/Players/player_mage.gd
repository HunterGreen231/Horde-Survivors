extends CharacterBody2D

# Player properties
var speed: int = 100
var health: int = 100

var nodesInArea = []

# Animation nodes
@onready var mageAnim = get_node("MageAnimationPlayer")
@onready var basicAttackAnim = get_node("AttackGroup/BasicAttack/BasicAttackAnimSprite")
@onready var mageAnimSprite = get_node("PlayerMageAnimSprite")
@onready var healthBar = get_node("../../CanvasLayer/HealthBarNode/HealthBar")

func _ready():
	pass
	
func take_damage():
	health -= 10
	if (health <= 0):
		player_death()
	
func player_death():
	get_tree().change_scene_to_file("res://Game Files/Main Menu/MainMenu.tscn")

func _process(delta):
	healthBar.value = health
	
	if(basicAttackAnim.is_playing()):
		if basicAttackAnim.frame >= 2 && basicAttackAnim.frame <= 5:
			destroy_enemies_in_basic_attack_area()
	
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
	
func destroy_enemies_in_basic_attack_area():
	for node in nodesInArea:
		node.queue_free()
	nodesInArea.clear()

func _on_basic_attack_timer_timeout():
	basicAttackAnim.play("Attack")

func _on_basic_attack_area_area_entered(area):
	var skeleton = area.get_parent()
	if not nodesInArea.has(skeleton):
		nodesInArea.append(skeleton)

func _on_basic_attack_area_area_exited(area):
	var skeleton = area.get_parent()
	if nodesInArea.has(skeleton):
		nodesInArea.erase(skeleton)
