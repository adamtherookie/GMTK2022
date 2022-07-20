extends CanvasLayer

func _process(delta):
	yield(get_tree().create_timer(1), "timeout")
	Globals.time += 0.01
	$ScoreLabel.text = "Time: " + str(Globals.time)
