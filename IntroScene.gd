extends Node2D
@onready var _Dialogue = load("res://Test.dialogue")
@onready var _DialogueLabel = $Node/DialogueLabel

func _ready():
	DialogueManager.show_dialogue_balloon(_Dialogue)
	DialogueManager.get_next_dialogue_line(_Dialogue)
