extends CharacterBody2D

#movement variables
@export var SPEED : float = 300.0
@export var JUMP_VELOCITY : float = -40.0
@export var DASH_SPEED : float = 300.0
@export var HEALTH_MAX : float = 200.0

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

#key variable
var has_key : bool = false

func _ready():
	timerNode = get_node("DmgCD")
	player_sprite = get_node("Sprite2D")
	health = HEALTH_MAX
	await owner.ready
	spawn()

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

	if Input.is_action_just_pressed("right_click") and canDash:
		canDash = false
		position.y += DASH_SPEED

	move_and_slide()
	
	#checar si la colision es con enemigo
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("enemy") and canGetHurt:
			hurt(collision.get_collider().get_dmg())
		elif collision.get_collider().is_in_group("heal"):
			heal(collision.get_collider().get_heal())
			collision.get_collider().queue_free()
		elif collision.get_collider().is_in_group("key"):
			has_key = true
			collision.get_collider().queue_free()
		elif collision.get_collider().is_in_group("door") and has_key:
			get_parent().ending_reached = true
			
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
	if(health <= 0):
		die()

func heal(hp):
	health += hp
	if health > HEALTH_MAX:
		health = HEALTH_MAX
	health_signal.emit(health)

func _on_dmg_cd_timeout():
	canGetHurt = true

func spawn():
	if get_parent().checkpoint_reached:
		var checkpoint = get_node("../checkpoint")
		health = HEALTH_MAX
		position = checkpoint.position
	else:
		var spawnv = get_node("../spawn")
		get_parent().reset()
		health = HEALTH_MAX
		position = spawnv.position

func die():
	spawn()
	health_signal.emit(health)
