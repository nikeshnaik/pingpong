extends StaticBody2D


# Called when the node enters the scene tree for the first time.
@onready var ball = get_node("./playarea/Ball") 
@onready var player = get_node("./playarea/player")
@onready var computer = get_node("./playarea/computer")
@onready var left_border = self.get_node("left")
@onready var right_border = self.get_node("right")
@onready var top_border = self.get_node("top")
@onready var bottom_border = self.get_node("bottom")

func _ready() -> void:
	print("Game start")
	self.startup()
	
func startup() -> void:
	self.reset()


func reset() -> void:
	if Globals.current_player == "computer":
		ball.global_position.x = player.global_position.x - 7
		ball.global_position.y = player.global_position.y + 10
	else:
		ball.global_position.x = computer.global_position.x - 13
		ball.global_position.y = computer.global_position.y + 10
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		ball.launch_ball()

func _physics_process(delta: float) -> void:
	pass


func _on_ball_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	var colliding_node:CollisionShape2D = body.shape_owner_get_owner(body.shape_find_owner(body_shape_index))
	
	if colliding_node.is_in_group("left_border"):
		print("Left Border")
	elif colliding_node.is_in_group("right_border"):
		print("right border")
	elif colliding_node.is_in_group("Player"):
		print("Player")	
	elif colliding_node.is_in_group("Computer"):
		print("Computer")
	else:
		print(colliding_node)
