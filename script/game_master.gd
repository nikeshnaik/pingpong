extends StaticBody2D


# Called when the node enters the scene tree for the first time.
@onready var ball = get_node("./playarea/Ball") 
@onready var player = get_node("./playarea/player")
@onready var computer = get_node("./playarea/computer")
@onready var left_border = self.get_node("left")
@onready var right_border = self.get_node("right")
@onready var top_border = self.get_node("top")
@onready var bottom_border = self.get_node("bottom")

@onready var p1score = self.get_node("./CanvasLayer/p1-score")
@onready var p2score = self.get_node("./CanvasLayer/p2-score")
@onready var timer = self.get_node("Timer")
@onready var timerlabel = self.get_node("./CanvasLayer/Time")
@onready var canvaslayer = self.get_node("./CanvasLayer")

class Player:
	var player_id
	var score
	var side
	
	func _init(player_id:String, side:String) -> void:
		player_id = player_id
		side = side
		score = 0
	
	func update_score(delta:int) -> void:
		score = score + delta
	
	func get_score():
		return str(score)


var player1 = Player.new("player1", "left")
var player2 = Player.new("player2", "right")

signal p1update_label(newscore)
signal p2update_label(newscore)


func _ready() -> void:
	self.connect("p1update_label", Callable(canvaslayer, "p1score_update_label"))
	self.connect("p2update_label", Callable(canvaslayer, "p2score_update_label"))
	self.reset()
	print("Game resetted, before start")



func reset() -> void:
	timer.start()
	
	if Globals.current_player == "computer":
		ball.global_position.x = player.global_position.x - 7
		ball.global_position.y = player.global_position.y + 10
	else:
		ball.global_position.x = computer.global_position.x - 13
		ball.global_position.y = computer.global_position.y + 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var remaining_time = int($Timer.time_left) 
	var minutes = remaining_time / 60          # Calculate minutes
	var seconds = remaining_time % 60          # Calculate seconds
	timerlabel.text = str(minutes) + ":" + str(seconds).pad_zeros(2)  # Format as MM:SS
	 
	computer.global_position.y += paddle_ai() * delta
	
	if Input.is_action_pressed("ui_accept"):
		ball.launch_ball()

	if remaining_time <= 0:
		stop_game()

func stop_game():
	print("Timer reached zero. Stopping the game.")
	get_tree().paused = true  # Pause the game
	# You can also use this to show a game over screen or something else
	# get_tree().quit()  # Uncomment to quit the game entirely if needed

func paddle_ai():
	var max_speed = 850.0  # Paddle maximum speed, slightly higher than the ball speed
	var paddle_speed = 800.0  # Paddle's base speed (matches ball speed)
	var randomness = 100.0  # Random speed boost for unpredictability
	
	var direction = sign(ball.global_position.y - computer.global_position.y)
	
	# Match the ball's speed with a buffer for precision
	var speed_to_match = clamp(abs(ball.ball_speed), computer.velocity.y, max_speed)
	
	# Add random speed boost to make the paddle unpredictable
	var random_boost = randf() * randomness if randi() % 10 == 0 else 0
	
	# Final speed, accounting for the direction
	return direction * (speed_to_match + random_boost)
	

func _physics_process(delta: float) -> void:
	pass

func _on_ball_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	var colliding_node:CollisionShape2D = body.shape_owner_get_owner(body.shape_find_owner(body_shape_index))
	
	if colliding_node.is_in_group("left_border"):
		print("Left Border")
		player1.update_score(1)
		emit_signal("p1update_label", player1.get_score())
	elif colliding_node.is_in_group("right_border"):
		print("right border")
		player2.update_score(1)
		emit_signal("p2update_label",  player2.get_score())
	elif colliding_node.is_in_group("Player"):
		print("Player")	
	elif colliding_node.is_in_group("Computer"):
		print("Computer")
	else:
		print(colliding_node)
