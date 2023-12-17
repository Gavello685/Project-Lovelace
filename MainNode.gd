extends Node

@onready var _cursor = $CursorNode/AnimatedSprite2D
@onready var _cursorSprite = $CursorNode
@onready var _Xlabel = $XLabel
@onready var _YLabel = $YLabel
var tileSize = 32
var mapWidth = 20
var mapHeight = 20
var xPos = 0
var yPos = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_drawMap()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	xPos = (_cursorSprite.position.x - tileSize/2) / tileSize + 1
	yPos = (_cursorSprite.position.y - tileSize/2) / tileSize + 1
	_cursor.play("default")
	_Xlabel.text = "X: " + str(xPos)
	_YLabel.text = "Y: " + str(yPos)
	pass


func _drawMap():
	var x = -tileSize/2
	var y = -tileSize/2
	for n in mapWidth:
		y = -tileSize/2
		x += tileSize
		for j in mapHeight:
			y += tileSize
			var tileBody = StaticBody2D.new()
			var tileCol = CollisionShape2D.new()
			tileBody.add_child(tileCol)
			var tileSprite = Sprite2D.new()
			tileSprite.texture = load('res://grass.jpg')
			tileBody.add_child(tileSprite)
			tileBody.global_position = Vector2(x,y)
			$MapNode.add_child(tileBody)
