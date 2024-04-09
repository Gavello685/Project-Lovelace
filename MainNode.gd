extends Node

@onready var _tileMap = $TileMap
@onready var _cursorSprite = $CursorNode/AnimatedSprite2D
@onready var _cursor = $CursorNode
@onready var _Xlabel = $Node/XLabel
@onready var _YLabel = $Node/YLabel
@onready var _TurnLabel = $Node/TurnLabel
@onready var _Selectlabel = $Node/SelectLabel
@onready var _BackLabel = $Node/BackLabel
@onready var _StartLabel = $Node/StartLabel
@onready var _BattleMenu = $CursorNode/PopupMenu

var tileSize = 32
var mapWidth = 20
var mapHeight = 20
var xPos = 0
var yPos = 0
var turn = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_Selectlabel.text = "Select: Z"
	_BackLabel.text = "Back: X"
	_StartLabel.text = "Start: Enter"
	
	for unit in Global.units:
		_tileMap.add_child(unit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	xPos = (_cursor.position.x - tileSize/2) / tileSize + 1
	yPos = (_cursor.position.y - tileSize/2) / tileSize + 1
	_cursorSprite.play("default")
	_Xlabel.text = "X: " + str(xPos)
	_YLabel.text = "Y: " + str(yPos)
	_TurnLabel.text = "Turn: " + str(floor(turn / 2))
	pass
	
	# Handles unit selection
func _unhandled_input(event):
	for unit in Global.units:
		if event.is_action_pressed("select") and unit.overlaps_area(_cursor) and unit.charData.team == turn % 2 and !unit.unit_selected:
			_unit_toggle(unit)
		elif event.is_action_pressed("back"):
			unit.unit_selected = false
		if event.is_action_pressed("select") and unit.unit_selected and unit.position != unit.startPos:
			_BattleMenu.clear()
			populateMenu(unit)
			_BattleMenu.position = _cursor.position
			_cursor.add_child(_BattleMenu)
			_BattleMenu.show()
	if event.is_action_pressed("start"):
		turn+= 1

	# Toggles unit selection
func _unit_toggle(unit: Unit): 
		unit.startPos = unit.position
		if !unit.unit_selected:
			unit.unit_selected = true
		else:
			unit.unit_selected = false

func populateMenu(unit: Unit):
	for menuId in unit.charData.selectedMenuIds:
		_BattleMenu.add_item(unit.charData.charClass.allMenuOptions[menuId],menuId)

func _combat_start(unit1: Unit, unit2: Unit):
	if unit1.charData.team != unit2.charData.team:
		print("Combat Started!")

func _on_popup_menu_id_pressed(id):
	match id:
		CharClass.allMenuIds.Attack:
			print("Attack")
		CharClass.allMenuIds.Items:
			print("Items")
		CharClass.allMenuIds.Magic:
			print("Magic")
		CharClass.allMenuIds.Steal:
			print("Steal")
		CharClass.allMenuIds.Defend:
			print("Defend")
