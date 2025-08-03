extends TileMapLayer

@export var move_distance := 100.0
@export var move_speed := 100.0
@export var move_axis := Vector2.RIGHT  
var origin := Vector2.ZERO
var direction := 1

func _ready():
	origin = position

func _process(delta):
	if not Globals.stopped:
		position += move_axis * direction * move_speed * delta

		
		var offset = position - origin
		if offset.length() >= move_distance:
			direction *= -1
	else:
		pass
