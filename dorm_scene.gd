extends Node2D

@onready var _Dorm_Dialogue = load("res://Dialogue/Dorm.dialogue")
@onready var _DialogueLabel = $Node/DialogueLabel

func _ready():
	DialogueManager.show_dialogue_balloon(_Dorm_Dialogue)
	DialogueManager.get_next_dialogue_line(_Dorm_Dialogue)
	DialogueManager.dialogue_ended.connect(_dorm_dialogue_ended)

func _dorm_dialogue_ended(_Dorm_Dialogue):
	Global.goto_scene("res://IntroScene.tscn")
