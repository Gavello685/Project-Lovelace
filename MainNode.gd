extends Node

@onready var _tileMap = $TileMap
@onready var _cursorSprite = $CursorNode/AnimatedSprite2D
@onready var _cursor = $CursorNode
@onready var _Xlabel = $Node/XLabel
@onready var _YLabel = $Node/YLabel
@onready var _TurnLabel = $Node/TurnLabel
@onready var _units = []

var tileSize = 32
var mapWidth = 20
var mapHeight = 20
var xPos = 0
var yPos = 0
var turn = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var unit1 = Unit.new("Joan",6,"Mage",6,19,12,4,8,0,"res://icon.svg")
	unit1.position = Vector2(128-16,128-16)
	_units.append(unit1)
	var unit2 = Unit.new("Roger",14,"Rogue",9,15,4,6,5,1,"res://icon.svg")
	unit2.position = Vector2(6*32-16,6*32-16)
	_units.append(unit2)
	for unit in _units:
		_tileMap.add_child(unit)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	xPos = (_cursor.position.x - tileSize/2) / tileSize + 1
	yPos = (_cursor.position.y - tileSize/2) / tileSize + 1
	_cursorSprite.play("default")
	_Xlabel.text = "X: " + str(xPos)
	_YLabel.text = "Y: " + str(yPos)
	_TurnLabel.text = "Turn: " + str(floor(turn / 2))
	pass
	
	# Handles unit selection
func _unhandled_input(event):
	for unit in _units:
		if event.is_action_pressed("select") and unit.overlaps_area(_cursor) and unit._team == turn % 2 and !unit.unit_selected:
			_unit_toggle(unit)
		elif event.is_action_pressed("back"):
			unit.unit_selected = false
		if event.is_action_pressed("select") and unit.unit_selected and unit.position != unit._startPos:
			var menu = PopupMenu.new()
			menu.add_item("Attack")
			menu.add_item("Item")
			menu.position = _cursor.position
			_cursor.add_child(menu)
			menu.show()
	if event.is_action_pressed("start"):
		turn+= 1

	# Toggles unit selection
func _unit_toggle(unit): 
		unit._startPos = unit.position
		if !unit.unit_selected:
			unit.unit_selected = true
		else:
			unit.unit_selected = false
	
func _combat_start(unit1, unit2):
	if unit1.team != unit2.team:
		print("Combat Started!")
