extends Area2D

func _ready():
	pass

func _on_body_entered(body):
	print("Collided with:", body.name)
