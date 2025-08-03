extends CharacterBody2D

var alive = true
const SPEED = 300.0
const JUMP_VELOCITY = 400.0
var GRAVITY = 1500.0
var current_scene_name = ""


func _ready():
	var current_scene = get_tree().current_scene
	current_scene_name = current_scene.name
	

func _physics_process(delta: float) -> void:
	
	if alive:
		velocity.y += GRAVITY * delta

		var grounded := is_on_floor() or is_on_ceiling()
		if Input.is_action_just_pressed("Jump") and grounded:
			velocity.y = -sign(GRAVITY) * JUMP_VELOCITY

		if Input.is_action_just_pressed("g-switch") and grounded:
			GRAVITY *= -1
			Globals.gravity_sign *= -1
		if current_scene_name == "Level3":
			if Input.is_action_just_pressed("timestop"):
				if Globals.stopped == true:
					Globals.stopped = false
				elif Globals.stopped == false:
					Globals.stopped = true


		var direction := Input.get_axis("Left", "Right")
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()

		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()

			if collider is RigidBody2D:
				var force = Vector2(direction * 100, 0)
				collider.apply_central_impulse(force)


			elif collider.name == "TileMapLayer2":
				print("Player entered the deadly zone!")
				alive = false
				game_over()
				break


func game_over():
	print("GAME OVER")

	$CanvasLayer/Label.text = "GAME OVER"
	$CanvasLayer/Label.visible = true
	set_physics_process(false)
