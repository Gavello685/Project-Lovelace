extends Area2D

@onready var mapInfo = get_node("/root/MainNode")
var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN,
}

func _ready():
	pass

func _unhandled_input(event):
	var selectedUnit: Array[Unit] = Global.units.filter(func(unit: Unit): return unit.unit_selected)
	if selectedUnit.size() == 0:
		for dir in inputs.keys():
			if event.is_action_pressed(dir):
					move(dir)
		
func move(dir):
	position += inputs[dir] * mapInfo.tileSize

