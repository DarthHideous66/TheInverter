extends CollisionShape2D

var current_scene_name = ""

func _ready():
    var area = get_parent()
    var current_scene = get_tree().current_scene
    current_scene_name = current_scene.name
    if area is Area2D:
        print("Found Area2D, connecting signal...")
        area.body_entered.connect(_on_body_entered)
    else:
        print("Parent is not Area2D!")

func _on_body_entered(body):
    if body.name == "CharacterBody2D":
        if current_scene_name == "Level1":
            get_tree().change_scene_to_file("res://level 2.tscn")
        elif current_scene_name == "Level2":
            get_tree().change_scene_to_file("res://level 3.tscn")
        elif current_scene_name == "Level3":
            get_tree().change_scene_to_file("res://level 4.tscn")

func _process(delta):
    if Globals.deaths >= 5:
        get_tree().change_scene_to_file("res://level 1.tscn")
        
        Globals.deaths = 0
    if Input.is_action_just_pressed("reset"):
        get_tree().reload_current_scene()
        Globals.gravity_sign = 1
