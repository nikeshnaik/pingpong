extends CharacterBody2D


@onready var right_border = self.get_node("../../right")
@onready var top_border = self.get_node("../../top")
@onready var bottom_border = self.get_node("../../bottom")

func _physics_process(delta: float) -> void:
	#
	velocity = Vector2.ZERO
	#
	#if Input.is_action_pressed("ui_up"):
		#velocity.y = -speed
	#elif Input.is_action_pressed("ui_down"):
		#velocity.y = speed
		#
	#velocity.x = 0
	#move_and_slide()
	

	
	global_position.x = right_border.global_position.x - 10
	global_position.y = clamp(global_position.y, top_border.global_position.y + 25.0, bottom_border.global_position.y - 60.0)
	
