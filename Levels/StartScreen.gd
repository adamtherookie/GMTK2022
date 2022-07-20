extends Node2D

func _ready():
	Menu.play()

func _process(delta):
	var rot_speed = PI / 2 
	$Dice.rotation = $Dice.rotation + rot_speed * delta

func _on_TextureButton_pressed():
	Menu.stop()
	get_tree().change_scene_to(load("res://Levels/Tutorial.tscn"))
	Music.play()
