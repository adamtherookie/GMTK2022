extends KinematicBody2D

export var start_health = 6
export var speed = 100
export var gravity = 500
export var stomp_impulse = 200

var velocity = Vector2.ZERO

var health = start_health

func _physics_process(delta):
	velocity.x += speed * delta 
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_wall():
		speed *= -1
	
func _on_Hitbox_body_entered(body):
	if body.name == "Player":
		body.velocity.y -= stomp_impulse
		body.get_node("Jump").play()
		Globals.health += 1
		health -= 1
	
	if health == 6:
		$Sprite.texture = load("res://Characters/enemy-6.png")
	elif health == 5:
		$Sprite.texture = load("res://Characters/enemy-5.png")
	elif health == 4:
		$Sprite.texture = load("res://Characters/enemy-4.png")
	elif health == 3:
		$Sprite.texture = load("res://Characters/enemy-3.png")
	elif health == 2:
		$Sprite.texture = load("res://Characters/enemy-2.png")
	elif health == 1:
		$Sprite.texture = load("res://Characters/enemy-1.png")
	else:
		Globals.time -= 3
		Globals.kills += 1
		$Death.play()
		queue_free()
