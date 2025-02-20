extends Control


func _on_volume_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)


func _on_button_pressed():
	Global.goto_scene("res://main_menu.tscn")
