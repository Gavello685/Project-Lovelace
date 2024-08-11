extends Node

var item_data = {}
var units: Array[Array]
var data_file_path = "res://units_test.json"
var current_scene = null
var rng = RandomNumberGenerator.new()

var directions = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN,
}

enum unit_team {PLAYER, ENEMY, ALLY}

func _ready():
	units.resize(3)
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	item_data = load_json_file(data_file_path)

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

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

func gridToPosition(x,y) -> Vector2:
	return Vector2(x*32-16,y*32-16)

func positionToGrid(position: Vector2) -> Vector2:
	return Vector2((position.x+16)/32,(position.y+16)/32)

func randomPosition() -> Vector2:
	var x = Global.rng.randi_range(1, 12)
	var y = Global.rng.randi_range(1, 8)
	return gridToPosition(x,y)

func get_all_file_paths(path_root: String) -> Array[String]:  
	var file_paths: Array[String] = []  
	var dir = DirAccess.open(path_root)  
	dir.list_dir_begin()  
	var file_name = dir.get_next()  
	while file_name != "":  
		var file_path = path_root + file_name  
		if dir.current_is_dir():  
			file_paths += get_all_file_paths(file_path)  
		else:  
			file_paths.append(file_path)  
		file_name = dir.get_next()  
	return file_paths

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
