extends Button

func _on_pressed():
	var unit1 = Unit.new("res://Characters/Joan.tres",Vector2(4*32-16,4*32-16))
	Global.units.append(unit1)
	var unit2 = Unit.new("res://Characters/Roger.tres",Vector2(6*32-16,6*32-16))
	Global.units.append(unit2)
	Global.goto_scene("res://main_node.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_load_game_pressed():
	var unit1 = Unit.new("res://Characters/Person.tres",Vector2(1*32-16,8*32-16))
	unit1.charData = CharData.new("Keith","res://CharacterClasses/Warrior.tres",50,0)
	Global.units.append(unit1)
	var unit2 = Unit.new("res://Characters/Person.tres",Vector2(5*32-16,7*32-16))
	unit2.charData = CharData.new("Blake","res://CharacterClasses/Commoner.tres",12,1)
	Global.units.append(unit2)
	Global.goto_scene("res://main_node.tscn")
