extends Area2D

class_name Unit

var tileSize = 32
var unit_selected = false
var charData: CharData
var startPos: Vector2
var sprite = Sprite2D.new()
var shape = RectangleShape2D.new()
var hitbox = CollisionShape2D.new()
var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN,
}

func _init(p_charData = "res://Characters/Person.tres", p_startPos = Global.randomPosition(), p_sprite = "res://Sprites/icon.svg", p_shape = RectangleShape2D.new(), p_hitbox = CollisionShape2D.new()):
	charData = load(p_charData)
	startPos = p_startPos
	sprite = Sprite2D.new()
	sprite.texture = load(p_sprite)
	add_child(sprite)
	shape = p_shape
	shape.size = Vector2(1,1)
	hitbox = p_hitbox
	hitbox.shape = shape
	add_child(hitbox)
	scale = Vector2(0.25,0.25)

func _ready():
	position = startPos
	print(stringify())

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir) and unit_selected:
				move(dir)

func stringify() -> String:
	return str(charData.stringify(),"\nPosition:",position)

func move(dir):
	var newPosition = position + (inputs[dir] * tileSize)
	var overlappingUnits = Global.units.filter(func(unit): return newPosition == unit.position)
	if overlappingUnits.size() == 0:
		position = newPosition
