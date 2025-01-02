extends CharacterBody2D

var speed: float = 500.0
var top_limit: float = -285.0
var bottom_limit: float = 320.0

func _physics_process(delta: float) -> void:
	
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		velocity.y = -speed
	elif Input.is_action_pressed("ui_down"):
		velocity.y = speed
		
	velocity.x = 0
	move_and_slide()
	
	global_position.x = -465
	global_position.y = clamp(global_position.y, top_limit, bottom_limit)
