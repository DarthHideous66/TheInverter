extends RigidBody2D

var anchor_active := false
var current_scene_name = ""

func _ready():
	var current_scene = get_tree().current_scene
	current_scene_name = current_scene.name

func _physics_process(_delta):
	if current_scene_name in ["Level2", "Level3", "Level4"]:

		if Input.is_action_just_pressed("anchor"):
			anchor_active = !anchor_active
	

	if Globals.stopped:
		self.freeze = true
		return
	else:
		self.freeze = false

	if anchor_active:
		linear_velocity.y = 0
		linear_velocity.x = 0

	else:
		var gravity_force = Globals.gravity_sign * 1500.0 * mass
		apply_central_force(Vector2(0, gravity_force))
