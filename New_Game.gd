extends Button

func _on_pressed():
	Global.goto_scene("res://main_node.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_load_game_pressed():
	print(JSON.stringify(Global.item_data['units_newGame'][0].values(),"\t"))
	print(JSON.stringify(Global.item_data['units_newGame'][1].values(),"\t"))
