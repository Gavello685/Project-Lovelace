extends Area2D

class_name Unit

var tileSize = 32
var unit_selected = false
var defending = false
var charData: CharData
var startPos: Vector2
var sprite = AnimatedSprite2D.new()
var shape = RectangleShape2D.new()
var hitbox = CollisionShape2D.new()

func _init(p_charData = "Commoner", p_startPos = Global.randomPosition(), p_shape = RectangleShape2D.new(), p_hitbox = CollisionShape2D.new()):
	z_index = 2
	charData = load("res://Characters/"+p_charData+".tres")
	startPos = p_startPos
	position = startPos
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
	var shaderMaterial = ShaderMaterial.new()
	shaderMaterial.shader = load("res://addons/PaletteSwap.gdshader")
	shaderMaterial.set_shader_parameter("palette",load("res://Sprites/sprite_palette.png"))
	shaderMaterial.set_shader_parameter("palette_row",charData.team)
	sprite.material = shaderMaterial
	add_child(sprite)
	

func move(dir,inRange: Callable):
	if dir == "right":
		sprite.play("left",6)
		sprite.set_flip_h(true)
	else:
		sprite.play(dir,6)
		sprite.set_flip_h(false)
	var newPosition = position + (Global.directions[dir] * tileSize)
	var overlappingUnits = Global.units.filter(func(unit): return newPosition == unit.position)
	if overlappingUnits.size() == 0 && inRange.call(Global.positionToGrid(startPos),Global.positionToGrid(newPosition),charData.maxSpeed):
		position = newPosition
