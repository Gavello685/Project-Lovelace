extends Node

@onready var _cursor = $CursorNode/AnimatedSprite2D
@onready var _cursorSprite = $CursorNode
@onready var _Xlabel = $Node/XLabel
@onready var _YLabel = $Node/YLabel
@onready var _TerrainLabel = $Node/TerrainLabel
@onready var _TileMap = $TileMap
var tileSize = 32
var mapWidth = 20
var mapHeight = 20
var xPos = 0
var yPos = 0
var grass = load('res://grass.jpg')
var dirt = load('res://dirt.png')

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	xPos = (_cursorSprite.position.x - tileSize/2) / tileSize + 1
	yPos = (_cursorSprite.position.y - tileSize/2) / tileSize + 1
	_cursor.play("default")
	_Xlabel.text = "X: " + str(xPos)
	_YLabel.text = "Y: " + str(yPos)
	_TerrainLabel.text = str(_TileMap.get_cell_tile_data(0, Vector2i(xPos, yPos)).get_custom_data("TerrainType"))
	pass
