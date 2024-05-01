extends Resource

class_name CharData

@export var charName: String
@export var charClass: CharClass
@export var level: int
@export var team: int
@export var magicKnown: Array
@export var items: Dictionary
@export var selectedMenuIds: Array = [charClass.allMenuIds.Attack,charClass.allMenuIds.Items]
var availableMenuIds: Array = [charClass.allMenuIds.Attack,charClass.allMenuIds.Items]
var maxHp: int
var maxAttack: int
var maxDefense: int
var maxMagic: int
var maxSpeed: int
var currentHp: int

func _init(p_charName = "Default", p_charClass = "res://CharacterClasses/Commoner.tres", p_level = 1, p_team = 0, p_magicKnown = ["super blast","gobsmack","take it easy"], p_items = {"tincture":1, "trinkets":5}):
	charName = p_charName
	charClass = load(p_charClass)
	level = p_level
	generateStats()
	team = p_team
	magicKnown = p_magicKnown
	items = p_items

func generateStats():
	selectedMenuIds.append_array(charClass.menuIds)
	availableMenuIds.append_array(charClass.menuIds)
	maxHp = charClass.hp * level
	maxAttack = charClass.attack * level
	maxDefense = charClass.defense * level
	maxMagic = charClass.magic * level
	maxSpeed = charClass.speed * level
	currentHp = maxHp

func stringify() -> String:
	var ret = str("\nName: ",charName," (Level ",level,"):\nTeam:",team,"\nStats:","\n\tHP:",maxHp,"\n\tAttack:",maxAttack,"\n\tDefense:",maxDefense,"\n\tMagic:",maxMagic,"\n\tSpeed:",maxSpeed)
	if charClass:
		ret += charClass.stringify()
	return ret
