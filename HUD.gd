extends CanvasLayer

var scorecount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$MessageTimer.start()
	$ScoreTimer.start()

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func start_score():
	$ScoreTimer.start()

func stop_score():
	$ScoreTimer.stop()

func _on_MessageTimer_timeout():
	$Message.hide()

func _on_ScoreTimer_timeout():
	scorecount += 1
	$ScoreLabel.text = str(scorecount)