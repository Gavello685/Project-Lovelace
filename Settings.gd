extends Control

@onready var resolution_button = $MarginContainer/VBoxContainer/Resolution
var resolutions: Array[String] = ["1600 x 800", "800 x 600"]

func _ready():
	for resolution in resolutions:
		resolution_button.add_item(resolution)

func _on_volume_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)

func _on_main_menu_pressed():
	Global.goto_scene("res://main_menu_scene.tscn")


#func _on_apply_pressed():
#	var selected_res :String = resolution_button.get_item_text(resolution_button.get_selected_id())
#	var wanted_res = PackedStringArray[selected_res.split(" ")]
#	DisplayServer.window_set_size(Vector2(wanted_res[0],wanted_res[2]))
