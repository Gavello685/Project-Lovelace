extends Node

signal inputRight()
signal inputLeft()
signal inputUp()
signal inputDown()

var directions = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

func _unhandled_input(event):
	for dir in directions.keys():
		if event.is_action_pressed(dir):
			emit_signal("input" + dir.capitalize())
			print("input" + dir.capitalize())
