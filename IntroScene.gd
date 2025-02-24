extends Node2D
@onready var _Intro_Dialogue = load("res://Dialogue/Intro.dialogue")
@onready var _Dorm_Dialogue = load("res://Dialogue/Dorm.dialogue")
@onready var _DialogueLabel = $Node/DialogueLabel

func _ready():
	DialogueManager.show_dialogue_balloon(_Intro_Dialogue)
	DialogueManager.get_next_dialogue_line(_Intro_Dialogue)
	DialogueManager.dialogue_ended.connect(_intro_dialogue_ended)

func _intro_dialogue_ended(_Intro_Dialogue): 
	$MenuContainer/Dormitory.grab_focus()


func _on_dormitory_pressed():
	Global.goto_scene("res://dorm_scene.tscn")

func _on_cafeteria_pressed():
	Global.goto_scene("res://cafeteria_scene.tscn")
