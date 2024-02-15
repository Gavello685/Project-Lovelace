extends Resource

class_name bot_stats

@export var attack: int
@export var defense: int
@export var hp: int
@export var magic: int
@export var movement: int
@export var speed: int

func _init(p_attack = 0, p_defense = 0, p_hp = 0, p_magic = 0, p_movement = 0, p_speed = 0):
	self.attack = p_attack
	self.defense = p_defense
	self.hp = p_hp
	self.magic = p_magic
	self.movement = p_movement
	self.speed = p_speed

func _print():
	print("att:",attack,",def:",defense,",hp:",hp,",mag:",magic,",mov:",movement,",spd:",speed)
