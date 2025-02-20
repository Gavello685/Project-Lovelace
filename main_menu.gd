extends Control

func _ready():
	$MenuContainer/New_Game.grab_focus()


func _on_options_pressed():
	Global.goto_scene("res://Options.tscn")
