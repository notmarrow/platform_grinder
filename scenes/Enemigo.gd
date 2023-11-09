extends CharacterBody2D


var SPEED = 200
const RayCast_suelo_POSITION_x =44
const RayCast_pared_TARGET_POSITION_X = 45
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	velocity.x = SPEED
	$RayCast_suelo.position.x=RayCast_suelo_POSITION_x
	$RayCast_pared.target_position.x= RayCast_pared_TARGET_POSITION_X
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if not $RayCast_suelo.is_colliding() || $RayCast_pared.is_colliding():
		velocity.x *= -1
		$RayCast_suelo.position.x *= -1
		$RayCast_pared.target_position.x *= -1 
	
	move_and_slide()
