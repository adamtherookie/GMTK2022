extends Position2D

var enemy = preload("res://Characters/Enemy.tscn")
var curr_enemies = 0
var num_enemies

func _ready():
	$Timer.start()
	
	num_enemies = Globals.health
#		var e = enemy.instance()
#		e.position = self.position
#		add_child(e)

func _on_Timer_timeout():
	if curr_enemies < num_enemies:
		var e = enemy.instance()
		e.position = global_position - self.position
		add_child(e)
		
		curr_enemies += 1
