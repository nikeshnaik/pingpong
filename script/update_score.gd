extends CanvasLayer

@onready var p1score = self.get_node("./p1-score")
@onready var p2score = self.get_node("./p2-score")
@onready var timer_label = self.get_node("./Time")

func p1score_update_label(text):
	print("old score", p1score.text)
	print("new score", text)
	p1score.text = text
	
func p2score_update_label(text):
	print("old score", p2score.text)
	print("new score", text)
	p2score.text = text
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
