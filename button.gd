extends CollisionShape2D

func _ready():
	# Connect signals to your area (assumed parent or Area2D)
	var area = get_parent()
	area.connect("body_entered", Callable(self, "_on_body_entered"))
	area.connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body is CharacterBody2D or body is RigidBody2D:
		Globals.pressed = true

func _on_body_exited(body):
	if body is CharacterBody2D or body is RigidBody2D:
		Globals.pressed = false
