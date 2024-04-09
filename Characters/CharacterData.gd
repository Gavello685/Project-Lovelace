extends Resource

class_name CharData

@export var charName: String
@export var charClass: CharClass
@export var level: int
@export var team: int
@export var selectedMenuIds: Array[CharClass.allMenuIds] = [charClass.allMenuIds.Attack,charClass.allMenuIds.Items]
var availableMenuIds = [charClass.allMenuIds.Attack,charClass.allMenuIds.Items]
var maxHp: int
var maxAttack: int
var maxDefense: int
var maxMagic: int
var maxSpeed: int

func _init(p_charName = "Default", p_charClass = "res://CharacterClasses/Commoner.tres", p_level = 1, p_team = 0):
	charName = p_charName
	charClass = load(p_charClass)
	level = p_level
	generateStats()
	team = p_team

func generateStats():
	maxHp = charClass.hp * level
	maxAttack = charClass.attack * level
	maxDefense = charClass.defense * level
	maxMagic = charClass.magic * level
	maxSpeed = charClass.speed * level
	selectedMenuIds.append(charClass.menuIds)
	availableMenuIds.append(charClass.menuIds)

func stringify() -> String:
	var ret = str("\nName: ",charName," (Level ",level,"):\nTeam:",team,"\nStats:","\n\tHP:",maxHp,"\n\tAttack:",maxAttack,"\n\tDefense:",maxDefense,"\n\tMagic:",maxMagic,"\n\tSpeed:",maxSpeed)
	if charClass:
		ret += charClass.stringify()
	return ret
