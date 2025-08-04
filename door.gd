extends StaticBody2D

func _process(delta: float) -> void:
	if Globals.pressed:
		$CollisionShape2D.disabled = true
		$Sprite2D.hide()  
	else:
		$CollisionShape2D.disabled = false
		$Sprite2D.show()  
