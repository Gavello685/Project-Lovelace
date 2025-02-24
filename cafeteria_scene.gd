extends Node2D

@onready var _Cafeteria_Dialogue = load("res://Dialogue/Cafeteria.dialogue")
@onready var _DialogueLabel = $Node/DialogueLabel

func _ready():
	DialogueManager.show_dialogue_balloon(_Cafeteria_Dialogue)
	DialogueManager.get_next_dialogue_line(_Cafeteria_Dialogue)
	DialogueManager.dialogue_ended.connect(_cafeteria_dialogue_ended)

func _cafeteria_dialogue_ended(_Cafeteria_Dialogue):
	Global.goto_scene("res://IntroScene.tscn")
