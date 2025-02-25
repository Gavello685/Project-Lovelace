extends Control

func _ready():
	$MenuContainer/New_Game.grab_focus()


func _on_options_pressed():
	Global.goto_scene("res://Options.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_load_game_pressed():
	Global.goto_scene("res://LoadGame.tscn")

func _on_new_game_pressed():
	Global.goto_scene("res://intro_scene.tscn")
