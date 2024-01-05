extends Node

@onready var _cursorSprite = $CursorNode/AnimatedSprite2D
@onready var _cursor = $CursorNode
@onready var _Xlabel = $Node/XLabel
@onready var _YLabel = $Node/YLabel
@onready var _TileMap = $TileMap
@onready var _unit = $Unit
var tileSize = 32
var mapWidth = 20
var mapHeight = 20
var xPos = 0
var yPos = 0
var grass = load('res://grass.jpg')
var dirt = load('res://dirt.png')
var unit_selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	xPos = (_cursor.position.x - tileSize/2) / tileSize + 1
	yPos = (_cursor.position.y - tileSize/2) / tileSize + 1
	_cursorSprite.play("default")
	_Xlabel.text = "X: " + str(xPos)
	_YLabel.text = "Y: " + str(yPos)
	print(_unit.unit_selected)
	pass
	
func _unhandled_input(event):
	if event.is_action_pressed("select") and _unit.overlaps_body(_cursor):
		_unit.unit_selected = true
	elif event.is_action_pressed("back"):
		_unit.unit_selected = false
