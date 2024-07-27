extends Resource

class_name CharClass

enum allMenuIds {
	Attack,
	Items,
	Magic,
	Steal,
	Defend,
	Talk,
}

@export var className: String
@export var hp: int
@export var attack: int
@export var defense: int
@export var magic: int
@export var speed: int
@export var menuIds: Array[allMenuIds]
@export var spritePath: String

func _init(p_className = "Commoner", p_attack = 0, p_defense = 0, p_hp = 0, p_magic = 0, p_speed = 0, p_menuIds = [], p_spritePath = "res://Animations/Commoner.tres"):
	className = p_className
	hp = p_hp
	attack = p_attack
	defense = p_defense
	magic = p_magic
	speed = p_speed
	menuIds.assign(p_menuIds)
	spritePath = p_spritePath

func stringify() -> String:
	return str("\nClassName: ",className,"\n\tStatScaling:","\n\t\tHP:",hp,"\n\t\tAttack:",attack,"\n\t\tDefense:",defense,"\n\t\tMagic:",magic,"\n\t\tSpeed:",speed,"\n\t\tMenu IDs:",menuIds)
