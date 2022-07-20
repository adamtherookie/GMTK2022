extends KinematicBody2D

export (int) var speed = 200
export (int) var jump_speed = -250
export (int) var normal_gravity = 500
export (int) var super_gravity = 1000
export (int) var rotate_speed = 15
export (int) var start_health = 6
export var knockback = 1.5
export (int, 0, 200) var push = 50

var gravity = normal_gravity
var velocity = Vector2.ZERO

export (float, 0, 1.0) var friction = 0.2
export (float, 0, 1.0) var acceleration = 0.1

func _ready():
	$Sprite.texture = load("res://Characters/player-6.png")

func _physics_process(delta):
	var dir = 0
	if Input.is_action_pressed("right"):
		dir += 1
		rotation += rotate_speed * delta
	if Input.is_action_pressed("left"):
		dir -= 1
		rotation -= rotate_speed * delta
	if Input.is_action_pressed("down"):
		gravity = super_gravity
	else:
		gravity = normal_gravity
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI / 4, false)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("pushable"):
			collision.collider.apply_central_impulse(-collision.normal * push)
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
			$Jump.play()
	
	if position.y > 5000:
		get_tree().reload_current_scene()


func _on_Area2D_body_entered(body):
	if body.is_in_group("health"):
		$PowerUp.play()
		Globals.health += 1
		if Globals.health >= 6:
			Globals.health = 6
		body.queue_free()
	if body.is_in_group("enemies") and body.name != "Hitbox":
		$Damage.play()
		$Camera2D.add_trauma(0.3)
		Globals.health -= 1
	
	if Globals.health == 6:
		$Sprite.texture = load("res://Characters/player-6.png")
	elif Globals.health == 5:
		$Sprite.texture = load("res://Characters/player-5.png")
	elif Globals.health == 4:
		$Sprite.texture = load("res://Characters/player-4.png")
	elif Globals.health == 3:
		$Sprite.texture = load("res://Characters/player-3.png")
	elif Globals.health == 2:
		$Sprite.texture = load("res://Characters/player-2.png")
	elif Globals.health == 1:
		$Sprite.texture = load("res://Characters/player-1.png")
	else:
		Globals.health = 6
		get_tree().reload_current_scene()
