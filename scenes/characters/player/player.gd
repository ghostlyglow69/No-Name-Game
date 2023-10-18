extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -150.0
const DOUBLE_JUMP_VELOCITY = -200.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_on_ladder = false
var jumps = 0
var coins = 0

@onready var player_animations = $PlayerAnimations


func _physics_process(delta):
	var horizontal_direction = Input.get_axis("ui_left", "ui_right")
	var vertical_direction = Input.get_axis("ui_up", "ui_down")
	
	if is_on_ladder:
		# Бля, хуй пойми что не так с этой лестницей.
		velocity.y += vertical_direction * SPEED
	else:
		if is_on_floor():
			jumps = 0
		else:
			velocity.y += gravity * delta
		if Input.is_action_just_pressed("ui_accept"):
			if is_on_floor() or jumps < 2:
				if jumps == 1:
					velocity.y = DOUBLE_JUMP_VELOCITY
				else:
					velocity.y = JUMP_VELOCITY
				jumps += 1
				player_animations.play("jump")
		if horizontal_direction:
			if horizontal_direction == -1:
				player_animations.flip_h = true
			elif horizontal_direction == 1:
				player_animations.flip_h = false
			if velocity.y == 0:
				player_animations.play("walk")
			velocity.x = horizontal_direction * SPEED
		else:
			if velocity.y == 0:
				player_animations.play("idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
	move_and_slide()
