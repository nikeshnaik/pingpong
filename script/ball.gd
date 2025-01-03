extends RigidBody2D

@onready var trail = $Sprite2D/CPUParticles2D

var ball_speed = 1000
var attached_to_paddle = true
var paddle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	paddle = get_node("../../Player/CharacterBody2D/CollisionShape2D") as CollisionShape2D
	freeze = true
	
func _physics_process(delta: float) -> void:
	if attached_to_paddle:
		global_position.x = paddle.global_position.x + 25	
		global_position.y = paddle.global_position.y
	
	if Input.is_action_just_pressed("ui_accept"):
		launch_ball()

func launch_ball():
	attached_to_paddle = false
	freeze = false

	var angle_start = 180 if randf() > 0.5 else 0
	var random_angle = deg_to_rad(randf_range(angle_start, angle_start + 180))
	var direction = Vector2(cos(random_angle), sin(random_angle))

	linear_velocity = direction * ball_speed

	
func reset_ball():
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	freeze = true
	attached_to_paddle = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if linear_velocity.length() > 1:
		trail.emitting = true
		var angle = linear_velocity.angle()
		trail.rotation = angle
	else:
		trail.emitting = false
		
	
	
