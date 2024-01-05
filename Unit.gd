extends Area2D

@onready var _cursor = $"../CursorNode"
var unit_selected = false

var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN,
}

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir) and unit_selected:
				move(dir)

func move(dir):
	position += inputs[dir] * _cursor.mapInfo.tileSize
