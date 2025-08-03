extends Node

func _ready():
	$Timer.start()

func _on_timeout():
	Globals.stopped = false
	


func _on_timestopcooldown_timeout():
	print("hi") # Replace with function body.
