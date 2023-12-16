extends Node

@onready var _cursor = $CursorNode/AnimatedSprite2D
@onready var _cursorChar = $CursorNode

# Called when the node enters the scene tree for the first time.
func _ready():
	_drawMap()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_cursor.play("default")
	pass


func _drawMap():
	var x = -16
	var y = -16
	for n in 20:
		y = -16
		x += 32
		for j in 20:
			y += 32
			var tileBody = StaticBody2D.new()
			var tileCol = CollisionShape2D.new()
			tileBody.add_child(tileCol)
			var tileSprite = Sprite2D.new()
			tileSprite.texture = load('res://grass.jpg')
			tileBody.add_child(tileSprite)
			tileBody.global_position = Vector2(x,y)
			$MapNode.add_child(tileBody)
