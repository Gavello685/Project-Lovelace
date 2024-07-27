extends Node

enum inputStates {
	freeCursor,
	unitSelected,
	selectingTarget,
}

@onready var _tileMap: Pathfinding = $TileMap
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
@onready var _Dialogue = load("res://Test.dialogue")
@onready var _DialogueLabel = $Node/DialogueLabel
var selectedUnit: Unit
var adjacentEnemies: Array[Unit]
var targettedUnit: Unit
var targetingCallback: Callable
var inputState: inputStates
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
	var animation = "default"
	for unit in Global.units:
		if unit.overlaps_area(_cursor):
			if unit.unit_selected:
				animation = "ally_selected"
			elif unit.charData.team == turn % 2:
				animation = "ally"
			else:
				animation = "enemy"
	_cursorSprite.play(animation)
	xPos = (_cursor.position.x - tileSize/2) / tileSize + 1
	yPos = (_cursor.position.y - tileSize/2) / tileSize + 1
	_Xlabel.text = "X: " + str(xPos)
	_YLabel.text = "Y: " + str(yPos)
	_TurnLabel.text = "Turn: " + str(floor(turn / 2))
	_RoundLabel.text = "Round: " + str(turn % 2 + 1)
	
	# Handles unit selection
func _unhandled_input(event):
	match inputState:
		inputStates.freeCursor:
			for dir in Global.directions.keys():
				if event.is_action_pressed(dir):
					_cursor.move(dir)
			if _cursor.has_overlapping_areas():
				var overlappingUnit: Unit = _cursor.get_overlapping_areas()[0]
				if event.is_action_pressed("select") and overlappingUnit.charData.team == turn % 2:
					_unit_toggle(overlappingUnit, false)
					_tileMap.show_range(Global.positionToGrid(selectedUnit.position),selectedUnit.charData.maxSpeed)
					inputState = inputStates.unitSelected

		inputStates.unitSelected:
			for dir in Global.directions.keys():
				if event.is_action_pressed(dir):
					selectedUnit.move(dir,_tileMap.in_range)
					_cursor.position = selectedUnit.position
			if event.is_action_pressed("back"):
				_unit_toggle(selectedUnit, false)
				_BattleMenu.hide()
				inputState = inputStates.freeCursor
				_tileMap.clear_range()
			if event.is_action_pressed("select"):
				populateMenu(selectedUnit)
				_BattleMenu.position = _cursor.position
				_BattleMenu.show()

		inputStates.selectingTarget:
			if event.is_action_pressed("left") || event.is_action_pressed("up"):
				var previousIndex = (adjacentEnemies.find(targettedUnit) - 1) % adjacentEnemies.size()
				targettedUnit = adjacentEnemies[previousIndex]
				_cursor.position = targettedUnit.position
			if event.is_action_pressed("right") || event.is_action_pressed("down"):
				var nextIndex = (adjacentEnemies.find(targettedUnit) + 1) % adjacentEnemies.size()
				targettedUnit = adjacentEnemies[nextIndex]
				_cursor.position = targettedUnit.position
			if event.is_action_pressed("back"):
				inputState = inputStates.unitSelected
				_cursor.position = selectedUnit.position
				targettedUnit = null
				_BattleMenu.show()
			if event.is_action_pressed("select"):
				targetingCallback.call(selectedUnit, targettedUnit)

	if event.is_action_pressed("start"):
		advanceTurn()

	# Toggles unit selection
func _unit_toggle(unit: Unit, endTurn: bool):
	if !unit.unit_selected:
		unit.sprite.play("selected",2.5)
		unit.startPos = unit.position
		unit.unit_selected = true
		selectedUnit = unit
	else:
		if !endTurn:
			_cursor.position = unit.startPos
			unit.position = unit.startPos
		unit.sprite.play("idle",3)
		unit.unit_selected = false
		selectedUnit = null
	unit.sprite.flip_h = false

func advanceTurn():
	_tileMap.clear_range()
	_unit_toggle(selectedUnit, true)
	_BattleMenu.hide()
	inputState = inputStates.freeCursor
	turn += 1

func populateMenu(unit: Unit):
	_BattleMenu.clear()
	for menuId in unit.charData.selectedMenuIds:
		if menuId == CharClass.allMenuIds.Attack || menuId == CharClass.allMenuIds.Defend || menuId == CharClass.allMenuIds.Steal || menuId == CharClass.allMenuIds.Talk:
			_BattleMenu.add_item(CharClass.allMenuIds.keys()[menuId],menuId)
		elif menuId == CharClass.allMenuIds.Items:
			_ItemSubmenu.clear()
			_BattleMenu.add_submenu_item(CharClass.allMenuIds.keys()[menuId],_ItemSubmenu.name,menuId)
			if unit.charData.items.size() > 0:
				for item in unit.charData.items:
					_ItemSubmenu.add_item(CharData.allItems.keys()[item],item)
			else:
				_BattleMenu.set_item_disabled(1, true)
		elif menuId == CharClass.allMenuIds.Magic:
			_MagicSubmenu.clear()
			_BattleMenu.add_submenu_item(CharClass.allMenuIds.keys()[menuId],_MagicSubmenu.name,menuId)
			if unit.charData.spells.size() > 0:
				for spell in unit.charData.spells:
					_MagicSubmenu.add_item(CharData.allSpells.keys()[spell],spell)
			else: 
				_BattleMenu.set_item_disabled(_BattleMenu.get_item_index(menuId), true)

func isAdjacent(unit1: Unit, unit2: Unit) -> bool:
	if unit1.position.x == unit2.position.x:
		return unit1.position.y == unit2.position.y + 32 || unit1.position.y == unit2.position.y - 32
	if unit1.position.y == unit2.position.y:
		return unit1.position.x == unit2.position.x + 32 || unit1.position.x == unit2.position.x - 32
	return false

func findAdjacentEnemies(attacker: Unit) -> Array[Unit]:
	return Global.units.filter(func(unit): return attacker.charData.team != unit.charData.team && isAdjacent(attacker,unit))

func selectTarget(callback: Callable):
	adjacentEnemies = findAdjacentEnemies(selectedUnit)
	if adjacentEnemies.size() > 0:
		_BattleMenu.hide()
		targetingCallback = callback
		inputState = inputStates.selectingTarget
		targettedUnit = adjacentEnemies[0]
		_cursor.position = targettedUnit.position

func steal(thief: Unit, stuffHaver: Unit):
	var thiefAttempt = Global.rng.randi_range(1, thief.charData.maxSpeed)
	var stuffHaverAttempt = Global.rng.randi_range(1, stuffHaver.charData.maxSpeed)
	
	if thiefAttempt > stuffHaverAttempt and stuffHaver.charData.items.size() > 0:
		var itemStolenIndex = Global.rng.randi_range(0, stuffHaver.charData.items.size() - 1)
		var itemStolen = stuffHaver.charData.items.pop_at(itemStolenIndex)
		thief.charData.items.append(itemStolen)
		print("Steal Success: ",CharData.allItems.keys()[itemStolen])
	else:
		print("Steal Failed")
	advanceTurn()
		
func talk(yapper: Unit, Listener: Unit):
	DialogueManager.show_dialogue_balloon(_Dialogue)
	DialogueManager.get_next_dialogue_line(_Dialogue)
	advanceTurn()

func _combat_start(attacker: Unit, defender: Unit):
	print("Combat Started!")
	var damage = attacker.charData.maxAttack - (defender.charData.maxDefense * (int(defender.defending) + 1))
	damage = damage if damage > 1 else 1
	defender.charData.currentHp -=  damage
	print(attacker.charData.charName, " did ", damage, " damage to ", defender.charData.charName, " leaving ", defender.charData.currentHp, " out of ", defender.charData.maxHp, "HP remaining")
	advanceTurn()

func _on_battle_menu_id_pressed(id):
	match id:
		CharClass.allMenuIds.Attack:
			print("Attack")
			selectTarget(_combat_start)
		CharClass.allMenuIds.Steal:
			print("Steal")
			selectTarget(steal)
		CharClass.allMenuIds.Defend:
			print("Defend")
			selectedUnit.defending = true
			advanceTurn()
		CharClass.allMenuIds.Talk:
			print("Talk")
			selectTarget(talk)
		_:
			print("Battle Menu ID is not implemented")

func _on_item_submenu_index_pressed(index):
	selectedUnit.charData.useItem(index)
	_BattleMenu.set_item_disabled(1, true)


func _on_magic_submenu_index_pressed(index):
	print("M:", _MagicSubmenu.get_item_text(index))
	advanceTurn()
