extends CanvasLayer

var scorecount = 0

var fallsound = preload("res://Sounds/fall.ogg")
var fall_sounds = [fallsound]

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameOverLabel.hide()
	$RestartButton.hide()
	$QuitButton.hide()
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

func game_over():
	$ScoreTimer.stop()
	get_node("../MobSpawn").stopspawn()
	get_tree().call_group("mobs", "queue_free")
	$GameOverLabel.show()
	$RestartButton.show()
	$QuitButton.show()
	$AudioStreamPlayer.set_stream(fall_sounds[0])
	$AudioStreamPlayer.play()

func _on_RestartButton_pressed():
	$GameOverLabel.hide()
	$RestartButton.hide()
	get_tree().reload_current_scene() 


func _on_QuitButton_pressed():
	get_tree().quit()
