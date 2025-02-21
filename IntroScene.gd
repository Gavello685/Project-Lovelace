extends Node2D
@onready var _Dialogue = load("res://Dialogue/Intro.dialogue")
@onready var _DialogueLabel = $Node/DialogueLabel

func _ready():
	DialogueManager.show_dialogue_balloon(_Dialogue)
	DialogueManager.get_next_dialogue_line(_Dialogue)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended():
	$MenuContainer/Dormitory.grab_focus()
