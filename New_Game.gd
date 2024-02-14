extends Button

var item_data = {}
var data_file_path = "res://unit_test.json"

func _on_pressed():
	get_tree().change_scene_to_file("res://main_node.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_load_game_pressed():
	item_data = load_json_file(data_file_path)
	print(JSON.stringify(item_data,"\t"))


# HELPER FUNCTIONS
func load_json_file(filePath: String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedResults = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResults is Dictionary:
			return parsedResults
		else:
			print("Could not parse JSON file into dictionary")
			
	else:
		print("Could not find JSON file")
		
