extends Area2D

@onready var mapInfo = get_node("/root/MainNode")
var tileSize = 32
var startPos: Vector2

func move(dir):
	position += Global.directions[dir] * mapInfo.tileSize

func move_unit(dir, range, inRange: Callable):
	var newPosition = position + (Global.directions[dir] * tileSize)
	var overlappingUnit: Unit
	for team in Global.units:
		for unit in team:
			if newPosition == unit.position:
				overlappingUnit = unit
	if overlappingUnit == null && inRange.call(Global.positionToGrid(startPos),Global.positionToGrid(newPosition),range):
		position = newPosition
