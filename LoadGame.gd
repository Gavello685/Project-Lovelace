extends Node

var save1: Array[Unit]
var save2: Array[Unit]
var save3: Array[Unit]

# Called when the node enters the scene tree for the first time.
func _ready():
	var buttons = self.get_children()
	# save1
	var save1Unit1 = Unit.new()
	save1Unit1.charData = CharData.new("Parsen","Rogue",69,0)
	save1.append(save1Unit1)
	var save1Unit2 = Unit.new()
	save1Unit2.charData = CharData.new("Lex","Mage",70,1)
	save1.append(save1Unit2)
	buttons[0].set_text(save1[0].charData.charName + ' vs ' + save1[1].charData.charName)
	
	# save2
	var save2Unit1 = Unit.new()
	save2Unit1.charData = CharData.new("Keith","Warrior",50,0)
	save2.append(save2Unit1)
	var save2Unit2 = Unit.new()
	save2Unit2.charData = CharData.new("Blake","Commoner",12,1)
	save2.append(save2Unit2)
	buttons[1].set_text(save2[0].charData.charName + ' vs ' + save2[1].charData.charName)
	
	# save3
	var save3Unit1 = Unit.new()
	save3Unit1.charData = CharData.new("Dez","Warrior",1,0)
	save3.append(save3Unit1)
	var save3Unit2 = Unit.new()
	save3Unit2.charData = CharData.new("Dorian","Rogue",3,1)
	save3.append(save3Unit2)
	buttons[2].set_text(save3[0].charData.charName + ' vs ' + save3[1].charData.charName)
	
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
