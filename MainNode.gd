extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	_drawMap()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _drawMap():
	var x = 0
	var y = 0
	for n in 5:
		y = 0
		x += 128
		for j in 3:
			y += 128
			var tileBody = StaticBody2D.new()
			var tileCol = CollisionShape2D.new()
			tileBody.add_child(tileCol)
			var tileSprite = Sprite2D.new()
			tileSprite.texture = load('res://icon.svg')
			tileBody.add_child(tileSprite)
			tileBody.global_position = Vector2(x,y)
			$MapNode.add_child(tileBody)
