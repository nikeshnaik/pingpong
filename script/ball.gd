extends RigidBody2D

@onready var trail = $Sprite2D/CPUParticles2D

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if linear_velocity.length() > 1:
		trail.emitting = true
		var angle = linear_velocity.angle()
		trail.rotation = angle
	else:
		trail.emitting = false
