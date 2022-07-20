extends KinematicBody2D

export (int) var speed = 10
export (int) var move_max = 100

var startpos
var going = true

func _ready():
	startpos = position.x

func _physics_process(delta):
	if position.x < startpos + move_max and going:
		position.x += speed
	elif position.x >= startpos + move_max and going:
		speed *= -1
		going = false
	elif position.x > startpos and not going:
		position.x += speed
	elif position <= startpos and not going:
		speed *= -1
		going = true
