extends Area2D

export (PackedScene) var next_level

func _on_Portal_body_entered(body):
	if body.name == "Player":
		$Teleport.play()
		yield(get_tree().create_timer(0.2), "timeout")
		get_tree().change_scene_to(next_level)
