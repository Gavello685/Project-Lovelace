extends Area2D

class_name Unit

var tileSize = 32
var unit_selected = false

var _name
var _attack
var _class
var _defense
var _hp
var _magic
var _movement
var _speed
var _sprite = Sprite2D.new()
var _hitbox = CollisionShape2D.new()
var _shape = RectangleShape2D.new()

var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN,
}

func _init(name, attack, _class, defense, hp, magic, movement, speed, sprite):
	self._name = name
	self._attack = attack
	self._class = _class
	self._defense = defense
	self._hp = hp
	self._magic = magic
	self._movement = movement
	self._speed = speed
	self._sprite.texture = load(sprite)
	self.add_child(_sprite)
	self._shape.size = Vector2(1,1)
	self._hitbox.shape = _shape
	self.add_child(_hitbox)
	self.scale = Vector2(0.25,0.25)
	
	pass

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir) and unit_selected:
				move(dir)

func move(dir):
	position += inputs[dir] * tileSize
