extends CharacterBody2D

@onready var mapInfo = get_node("/root/MainNode")
@onready var _unit = $Unit
var overlap = false
var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN,
}

func _ready():
	pass

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
				move(dir)
		
func move(dir):
	position += inputs[dir] * mapInfo.tileSize

