extends Area2D

signal hit

@export var speed = 400
@onready var screen_size = get_viewport_rect().size
var velocity

func _ready():
	hide()

func _process(delta):
	velocity = Vector2.ZERO
	handle_keyboard()
	play_animation()
	update_position(delta)

func _on_body_entered(_body):
	hide()
	hit.emit()
	$Hitbox.set_deferred("disabled", true)

func handle_keyboard():
	if Input.is_action_pressed("go_right"):
		velocity.x += 1
	if Input.is_action_pressed("go_left"):
		velocity.x -= 1
	if Input.is_action_pressed("go_down"):
		velocity.y += 1
	if Input.is_action_pressed("go_up"):
		velocity.y -= 1

func play_animation():
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$Animation.play()
	else:
		$Animation.stop()
	
	# going left or right
	if velocity.x != 0:
		$Animation.animation = "walk"
		$Animation.flip_h = velocity.x < 0
	# up or down
	elif velocity.y != 0:
		$Animation.animation = "up"
		$Animation.flip_v = velocity.y > 0
	else:
		$Animation.animation = "walk"
		$Animation.flip_v = false

func update_position(delta: float):
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func start(pos):
	position = pos
	show()
	#$Hitbox.set_deferred("disabled", true)


func _on_game_started():
	$Hitbox.set_deferred("disabled", false)
