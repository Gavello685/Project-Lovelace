extends Button

func _on_pressed():
	var unit1 = Unit.new("res://Characters/Joan.tres",Global.position(4,4))
	unit1.charData.generateStats()
	unit1.sprite.texture = load("res://Animations/lyn_up.tres")
	Global.units.append(unit1)
	var unit2 = Unit.new("res://Characters/Roger.tres",Global.position(5,4))
	unit2.charData.generateStats()
	Global.units.append(unit2)
	var unit3 = Unit.new("res://Characters/Duane.tres",Global.position(5,5))
	unit3.charData.generateStats()
	Global.units.append(unit3)
	var unit4 = Unit.new("res://Characters/Leena.tres",Global.position(4,5))
	unit4.charData.generateStats()
	Global.units.append(unit4)
	Global.goto_scene("res://main_node.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_load_game_pressed():
	Global.goto_scene("res://LoadGame.tscn")
