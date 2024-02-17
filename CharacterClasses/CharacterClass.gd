extends Resource

class_name CharClass

@export var className: String
@export var hp: int
@export var attack: int
@export var defense: int
@export var magic: int
@export var speed: int

func _init(p_className = "Default", p_attack = 0, p_defense = 0, p_hp = 0, p_magic = 0, p_speed = 0):
	className = p_className
	hp = p_hp
	attack = p_attack
	defense = p_defense
	magic = p_magic
	speed = p_speed

func stringify() -> String:
	return str("\nClassName: ",className,"\n\tStatScaling:","\n\t\tHP:",hp,"\n\t\tAttack:",attack,"\n\t\tDefense:",defense,"\n\t\tMagic:",magic,"\n\t\tSpeed:",speed)
