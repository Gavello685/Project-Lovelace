extends Node

var save1: Array[Unit]
var save2: Array[Unit]
var save3: Array[Unit]

# Called when the node enters the scene tree for the first time.
func _ready():
	# save1
	var save1Unit1 = Unit.new("res://Characters/Person.tres")
	save1Unit1.charData = CharData.new("Parsen","res://CharacterClasses/Rogue.tres",69,0)
	save1.append(save1Unit1)
	var save1Unit2 = Unit.new("res://Characters/Person.tres")
	save1Unit2.charData = CharData.new("Lex","res://CharacterClasses/Mage.tres",70,1)
	save1.append(save1Unit2)
	
	# save2
	var save2Unit1 = Unit.new("res://Characters/Person.tres")
	save2Unit1.charData = CharData.new("Keith","res://CharacterClasses/Warrior.tres",50,0)
	save2.append(save2Unit1)
	var save2Unit2 = Unit.new("res://Characters/Person.tres")
	save2Unit2.charData = CharData.new("Blake","res://CharacterClasses/Commoner.tres",12,1)
	save2.append(save2Unit2)
	
	# save3
	var save3Unit1 = Unit.new("res://Characters/Person.tres")
	save3Unit1.charData = CharData.new("Dez","res://CharacterClasses/Warrior.tres",1,0)
	save3.append(save3Unit1)
	var save3Unit2 = Unit.new("res://Characters/Person.tres")
	save3Unit2.charData = CharData.new("Dorian","res://CharacterClasses/Rogue.tres",3,1)
	save3.append(save3Unit2)
	
	Global.units.clear()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_save_1_pressed():
	Global.units = save1
	Global.goto_scene("res://main_node.tscn")

func _on_save_2_pressed():
	Global.units = save2
	Global.goto_scene("res://main_node.tscn")
	pass

func _on_save_3_pressed():
	Global.units = save3
	Global.goto_scene("res://main_node.tscn")
	pass

func _on_cancel_pressed():
	Global.goto_scene("res://main_menu.tscn")
