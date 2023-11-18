extends CharacterBody2D

#movement variables
@export var SPEED : float = 300.0
@export var JUMP_VELOCITY : float = -40.0
@export var DASH_SPEED : float = 300.0

var canDash = true
var impulse = 0.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#health variables
@export var health : float = 200.0
var canGetHurt : bool = true # variable para cooldown de daño
var timerNode 

#animation variables
var intermittence_gap : float = 0.0
var player_sprite

#signals
signal health_signal(value)

func _ready():
	timerNode = get_node("DmgCD")
	player_sprite = get_node("Sprite2D")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		canDash = true

	if Input.is_action_pressed("space") and is_on_floor():
		impulse += JUMP_VELOCITY
		
	if Input.is_action_just_released("space") and is_on_floor():
		if impulse < -900:
			impulse = -900
		velocity.y = impulse
		impulse = 0.0

	var direction = Input.get_axis("a", "d")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("click") and canDash:
		canDash = false
		position.x += direction * DASH_SPEED

	move_and_slide()
	
	#checar si la colision es con enemigo
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("enemy") and canGetHurt:
			hurt(collision.get_collider().get_dmg())
			
func _process(delta):
	if not canGetHurt:
		intermittence_gap += delta
	else:
		intermittence_gap = 0.0
		if not player_sprite.is_visible():
			player_sprite.show()
	
	if intermittence_gap >= 0.2:
		if player_sprite.is_visible():
			player_sprite.hide()
		else:
			player_sprite.show()
		intermittence_gap = 0.0
		
	
func hurt(dmg):
	canGetHurt = false
	timerNode.start()
	health -= dmg
	health_signal.emit(health)


func _on_dmg_cd_timeout():
	canGetHurt = true
