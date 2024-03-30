extends Button

func _on_pressed():
	var unit1 = Unit.new("res://Characters/Joan.tres",Global.position(4,4))
	Global.units.append(unit1)
	var unit2 = Unit.new("res://Characters/Roger.tres",Global.position(6,6))
	Global.units.append(unit2)
	Global.goto_scene("res://main_node.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_load_game_pressed():	
	Global.goto_scene("res://LoadGame.tscn")
