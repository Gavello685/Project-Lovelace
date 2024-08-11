extends Button

func _on_pressed():
	var unit1 = Unit.new("Joan",Global.gridToPosition(2,2))
	unit1.charData.generateStats()
	Global.units[unit1.charData.team].append(unit1)
	var unit2 = Unit.new("Roger",Global.gridToPosition(3,3))
	unit2.charData.generateStats()
	Global.units[unit2.charData.team].append(unit2)
	var unit3 = Unit.new("Duane",Global.gridToPosition(4,2))
	unit3.charData.generateStats()
	Global.units[unit3.charData.team].append(unit3)
	var unit4 = Unit.new("Leena",Global.gridToPosition(4,5))
	unit4.charData.generateStats()
	Global.units[unit4.charData.team].append(unit4)
	var unit5 = Unit.new("Carmo",Global.gridToPosition(5,5))
	unit5.charData.generateStats()
	Global.units[unit5.charData.team].append(unit5)
	var unit6 = Unit.new("Janson",Global.gridToPosition(2,5))
	unit6.charData.generateStats()
	Global.units[unit6.charData.team].append(unit6)
	Global.goto_scene("res://main_node.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_load_game_pressed():
	Global.goto_scene("res://LoadGame.tscn")
