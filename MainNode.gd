extends Node

@onready var _tileMap = $TileMap
@onready var _cursorSprite = $CursorNode/AnimatedSprite2D
@onready var _cursor = $CursorNode
@onready var _Xlabel = $Node/XLabel
@onready var _YLabel = $Node/YLabel
@onready var _TurnLabel = $Node/TurnLabel
@onready var _RoundLabel = $Node/RoundLabel
@onready var _Selectlabel = $Node/SelectLabel
@onready var _BackLabel = $Node/BackLabel
@onready var _StartLabel = $Node/StartLabel
@onready var _BattleMenu = $CursorNode/BattleMenu
@onready var _ItemSubmenu = $CursorNode/BattleMenu/ItemSubmenu
@onready var _MagicSubmenu = $CursorNode/BattleMenu/MagicSubmenu

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
	var animation = "default"
	for unit in Global.units:
		if unit.overlaps_area(_cursor):
			if unit.charData.team == turn % 2:
				animation = "ally"
			else:
				animation = "enemy"
	_cursorSprite.play(animation)
	_Xlabel.text = "X: " + str(xPos)
	_YLabel.text = "Y: " + str(yPos)
	_TurnLabel.text = "Turn: " + str(floor(turn / 2))
	_RoundLabel.text = "Round: " + str(turn % 2 + 1)
	pass
	
	# Handles unit selection
func _unhandled_input(event):
	for unit in Global.units:
		if event.is_action_pressed("select") and unit.overlaps_area(_cursor) and unit.charData.team == turn % 2 and !unit.unit_selected:
			unit.unit_selected = true
		elif event.is_action_pressed("back"):
			unit.unit_selected = false
		elif event.is_action_pressed("select") and unit.unit_selected:
			populateMenu(unit)
			_BattleMenu.position = _cursor.position
			_BattleMenu.show()
	if event.is_action_pressed("start"):
		advanceTurn()

	# Toggles unit selection
func _unit_toggle(unit: Unit): 
		unit.startPos = unit.position
		if !unit.unit_selected:
			unit.unit_selected = true
		else:
			unit.unit_selected = false

func advanceTurn():
	turn += 1

func populateMenu(unit: Unit):
	_BattleMenu.clear()
	for menuId in unit.charData.selectedMenuIds:
		if menuId == CharClass.allMenuIds.Attack || menuId == CharClass.allMenuIds.Defend || menuId == CharClass.allMenuIds.Steal:
			_BattleMenu.add_item(unit.charData.charClass.allMenuOptions[menuId],menuId)
		elif menuId == CharClass.allMenuIds.Items:
			_ItemSubmenu.clear()
			for item in unit.charData.items:
				_ItemSubmenu.add_item(item+ " x"+str(unit.charData.items[item]))
			_BattleMenu.add_submenu_item(unit.charData.charClass.allMenuOptions[menuId],_ItemSubmenu.name,menuId)
		elif menuId == CharClass.allMenuIds.Magic:
			_MagicSubmenu.clear()
			for spell in unit.charData.magicKnown:
				_MagicSubmenu.add_item(spell)
			_BattleMenu.add_submenu_item(unit.charData.charClass.allMenuOptions[menuId],_MagicSubmenu.name,menuId)

func isAdjacent(unit1: Unit, unit2: Unit) -> bool:
	if unit1.position.x == unit2.position.x:
		return unit1.position.y == unit2.position.y + 32 || unit1.position.y == unit2.position.y - 32
	if unit1.position.y == unit2.position.y:
		return unit1.position.x == unit2.position.x + 32 || unit1.position.x == unit2.position.x - 32
	return false

func findAdjacentEnemies(attacker: Unit) -> Array[Unit]:
	return Global.units.filter(func(unit): return attacker.charData.team != unit.charData.team && isAdjacent(attacker,unit))

func _combat_start(attacker: Unit, defender: Unit):
	print("Combat Started!")
	var damage = attacker.charData.maxAttack - defender.charData.maxDefense
	damage = damage if damage > 1 else 1
	defender.charData.currentHp -=  damage
	print(attacker.charData.charName, " did ", damage, " damage to ", defender.charData.charName, " leaving ", defender.charData.currentHp, " out of ", defender.charData.maxHp, "HP remaining")

func _on_popup_menu_id_pressed(id):
	var selectedUnit: Unit = Global.units.filter(func(unit: Unit): return unit.unit_selected)[0]
	match id:
		CharClass.allMenuIds.Attack:
			print("Attack")
			var adjacentEnemies = findAdjacentEnemies(selectedUnit)
			if adjacentEnemies.size() > 0:
				_combat_start(selectedUnit, adjacentEnemies[0])
				selectedUnit.unit_selected = false
				advanceTurn()
		CharClass.allMenuIds.Items:
			print("Items")
		CharClass.allMenuIds.Magic:
			print("Magic")
		CharClass.allMenuIds.Steal:
			print("Steal")
		CharClass.allMenuIds.Defend:
			print("Defend")
