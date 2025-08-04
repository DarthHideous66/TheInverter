extends Control

func _on_button_pressed():  # Start Game button
	get_tree().change_scene_to_file("res://level 1.tscn")  # adjust path if needed
