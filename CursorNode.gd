extends Area2D

@onready var mapInfo = get_node("/root/MainNode")

func move(dir):
	position += Global.directions[dir] * mapInfo.tileSize
