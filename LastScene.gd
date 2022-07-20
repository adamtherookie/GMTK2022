extends Node2D

func _ready():
	Music.stop()
	Menu.play()
	$Label.text = "You made it, you're finally the king of the square dice! \n Kills: " + str(Globals.kills) + " | Time: " + str(Globals.time)
