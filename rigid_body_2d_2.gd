extends CharacterBody2D

var alive = true
const SPEED = 300.0
const JUMP_VELOCITY = 400.0  # positive
var GRAVITY = 1500.0

func _physics_process(delta: float) -> void:
	if alive:
		velocity.y += GRAVITY * delta

		# Handle jump (supports flipped gravity)
		var grounded := is_on_floor() or is_on_ceiling()
		if Input.is_action_just_pressed("Jump") and grounded:
			velocity.y = -sign(GRAVITY) * JUMP_VELOCITY

		# Flip gravity
		if Input.is_action_just_pressed("g-switch") and grounded:
			GRAVITY *= -1

		# Horizontal movement
		var direction := Input.get_axis("Left", "Right")
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		# Move and check for deadly tilemap collisions
		move_and_slide()

		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()

			if collider.name == "TileMapLayer2":  # Replace with your actual deadly tilemap node name
				print("Player entered the deadly zone!")
				alive = false
				game_over()
				break  # stop checking more collisions once dead

	else:
		pass
		# Optionally, you can do nothing here since game_over() handles the label display


func game_over():
	print("GAME OVER")
	$CanvasLayer/Label.text = "GAME OVER"
	$CanvasLayer/Label.visible = true

	# Optionally, stop physics processing if you want to freeze the player
	set_physics_process(false)

	# You can add code here to restart or change scenes if you want
	# get_tree().change_scene_to_file("res://GameOver.tscn")
