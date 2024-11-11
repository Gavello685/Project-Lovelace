extends Area2D

class_name Unit

var tileSize = 32
var unit_selected = false
var unit_used = false
var defending = false
var charData: CharData
var startPos: Vector2
var shaderMaterial = ShaderMaterial.new()
var sprite = AnimatedSprite2D.new()
var shape = RectangleShape2D.new()
var hitbox = CollisionShape2D.new()
var target: Unit

var directions = {
	Vector2.RIGHT: "right",
	Vector2.LEFT: "left",
	Vector2.UP: "up",
	Vector2.DOWN: "down",
}

func _init(p_charData = "Commoner", p_startPos = Global.randomPosition(), p_shape = RectangleShape2D.new(), p_hitbox = CollisionShape2D.new()):
	z_index = 3
	charData = load("res://Characters/"+p_charData+".tres")
	startPos = p_startPos
	position = startPos
	shaderMaterial.shader = load("res://addons/PaletteSwap.gdshader")
	shaderMaterial.set_shader_parameter("palette",load("res://Sprites/sprite_palette.png"))
	shape = p_shape
	shape.size = Vector2(1,1)
	hitbox = p_hitbox
	hitbox.shape = shape
	add_child(hitbox)
	scale = Vector2(0.25,0.25)

func _ready():
	pass

func stringify() -> String:
	return str(charData.stringify(),"\nPosition:",position)

func set_sprite_frames():
	if charData.spritePath_override:
		sprite.sprite_frames = load(charData.spritePath_override)
	else:
		sprite.sprite_frames = load(charData.charClass.spritePath)
	sprite.offset = Vector2(0,-64)
	sprite.play("idle",2.5)
	shaderMaterial.set_shader_parameter("palette_row",charData.team)
	sprite.material = shaderMaterial
	add_child(sprite)

func choose_ai_target():
	match charData.team:
		1:
			prints("enemy target select")
		2:
			prints("companions target select")
	

func complete_ai_move():
	pass

func move(path: Array[Vector2i]):
	path.pop_front()
	position = startPos
	for cell in path:
		var dir = (Vector2(cell) - Global.positionToGrid(position))
		match dir:
			Vector2.UP:
				sprite.play("up",6)
				sprite.set_flip_h(false)
			Vector2.DOWN:
				sprite.play("down",6)
				sprite.set_flip_h(false)
			Vector2.LEFT:
				sprite.play("left",6)
				sprite.set_flip_h(false)
			Vector2.RIGHT:
				sprite.play("left",6)
				sprite.set_flip_h(true)
		while position != Global.gridToPosition(cell.x,cell.y):
			position += dir
			await get_tree().create_timer(0).timeout
	return true
