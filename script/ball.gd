extends RigidBody2D

@onready var trail = $Sprite2D/CPUParticles2D

var initial_speed = 1000
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

	var direction =  Vector2(randf_range(-0.5, 0.5),-1).normalized()
	
	apply_central_impulse(direction * initial_speed)
	
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
		
	
	
