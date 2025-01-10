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

var scorep1 = 0
var scorep2 = 0
var time = 0

signal p1update_label(newscore)
signal p2update_label(newscore)


func _ready() -> void:
	self.connect("p1update_label", Callable(canvaslayer, "p1score_update_label"))
	self.connect("p2update_label", Callable(canvaslayer, "p2score_update_label"))
	#timer.wait_time = 10  # Set the timer to 2 minutes
	# Start the timer
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
	 
	if Input.is_action_pressed("ui_accept"):
		ball.launch_ball()

	if remaining_time <= 0:
		stop_game()

func stop_game():
	print("Timer reached zero. Stopping the game.")
	get_tree().paused = true  # Pause the game
	# You can also use this to show a game over screen or something else
	# get_tree().quit()  # Uncomment to quit the game entirely if needed

func _physics_process(delta: float) -> void:
	pass

func _on_ball_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	var colliding_node:CollisionShape2D = body.shape_owner_get_owner(body.shape_find_owner(body_shape_index))
	
	if colliding_node.is_in_group("left_border"):
		print("Left Border")
		scorep1 = scorep1 + 1
		emit_signal("p1update_label", str(scorep1))
	elif colliding_node.is_in_group("right_border"):
		print("right border")
		scorep2 = scorep2 + 1
		emit_signal("p2update_label",  str(scorep2))
	elif colliding_node.is_in_group("Player"):
		print("Player")	
	elif colliding_node.is_in_group("Computer"):
		print("Computer")
	else:
		print(colliding_node)
