extends RigidBody2D

@onready var trail = $Sprite2D/CPUParticles2D

var ball_speed = 800
var paddle
var direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

	
func _physics_process(delta: float) -> void:
	pass

func launch_ball():

	var angle_start = 180 if randf() > 0.5 else 0
	var random_angle = deg_to_rad(randf_range(angle_start, angle_start + 180))
	var direction = Vector2(cos(random_angle), sin(random_angle))

	linear_velocity = direction * ball_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if linear_velocity.length() > 1:
		trail.emitting = true
		var angle = linear_velocity.angle()
		trail.rotation = angle
	else:
		trail.emitting = false


func _on_body_entered(body: Node) -> void:
	pass # Replace with function body.
	

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	
	var velocity = state.linear_velocity
	
	# Check if the velocity is non-zero to avoid division by zero
	if velocity.length() > 0:
		# Normalize the velocity and scale it to the constant speed
		velocity = velocity.normalized() * ball_speed

	# Apply the modified velocity back
	state.linear_velocity = velocity
