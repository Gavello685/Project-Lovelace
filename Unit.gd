extends Area2D

class_name Unit

var tileSize = 32
var unit_selected = false
var defending = false
var charData: CharData
var startPos: Vector2
var sprite = Sprite2D.new()
var shape = RectangleShape2D.new()
var hitbox = CollisionShape2D.new()
var animations: Dictionary = {
	"idle": Texture2D,
	"hovered": Texture2D,
	"selected": Texture2D,
	"up": Texture2D,
	"lateral": Texture2D,
	"down": Texture2D,
}

func _init(p_charData = "res://Characters/Person.tres", p_startPos = Global.randomPosition(), p_anim_idle = "res://Sprites/icon.svg", p_shape = RectangleShape2D.new(), p_hitbox = CollisionShape2D.new()):
	z_index = 2
	charData = load(p_charData)
	startPos = p_startPos
	position = startPos
	sprite = Sprite2D.new()
	sprite.texture = load(p_anim_idle)
	add_child(sprite)
	shape = p_shape
	shape.size = Vector2(1,1)
	hitbox = p_hitbox
	hitbox.shape = shape
	add_child(hitbox)
	scale = Vector2(0.25,0.25)

func _ready():
	print(stringify())

func stringify() -> String:
	return str(charData.stringify(),"\nPosition:",position)

func move(dir,inRange: Callable):
	var newPosition = position + (Global.directions[dir] * tileSize)
	var overlappingUnits = Global.units.filter(func(unit): return newPosition == unit.position)
	if overlappingUnits.size() == 0 && inRange.call(Global.positionToGrid(startPos),Global.positionToGrid(newPosition),charData.maxSpeed):
		position = newPosition
