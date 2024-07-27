extends Resource

class_name CharData

enum allSpells {
	Blastaga,
	Gobsmack,
	RnR
}

enum allItems {
	Tincture,
	Trinket,
}

@export var charName: String
@export var charClass: CharClass
@export var level: int
@export var team: int
@export var spells: Array[allSpells]
@export var items: Array[allItems]
@export var spritePath_override: String
var selectedMenuIds: Array[CharClass.allMenuIds] = [charClass.allMenuIds.Attack,charClass.allMenuIds.Items,charClass.allMenuIds.Talk]
var availableMenuIds: Array[CharClass.allMenuIds] = [charClass.allMenuIds.Attack,charClass.allMenuIds.Items,charClass.allMenuIds.Talk]
var maxHp: int
var maxAttack: int
var maxDefense: int
var maxMagic: int
var maxSpeed: int
var currentHp: int

func _init(p_charName = "Commoner", p_charClass = "Commoner", p_level = 1, p_team = 0, p_spells = [], p_items = [allItems.Tincture, allItems.Trinket], p_spritePath_override = ""):
	charName = p_charName
	charClass = load("res://CharacterClasses/"+p_charClass+".tres")
	level = p_level
	generateStats()
	team = p_team
	spells.assign(p_spells)
	items.assign(p_items)
	spritePath_override = p_spritePath_override

func generateStats():
	selectedMenuIds.append_array(charClass.menuIds)
	availableMenuIds.append_array(charClass.menuIds)
	maxHp = charClass.hp * level
	maxAttack = charClass.attack * level
	maxDefense = charClass.defense * level
	maxMagic = charClass.magic * level
	maxSpeed = charClass.speed * level
	currentHp = maxHp

func useItem(index: int):
	var itemUsed = items.pop_at(index)
	print("Item Used: ",CharData.allItems.keys()[itemUsed])

func stringify() -> String:
	var ret = str("\nName: ",charName," (Level ",level,"):\nTeam:",team,"\nStats:","\n\tHP:",maxHp,"\n\tAttack:",maxAttack,"\n\tDefense:",maxDefense,"\n\tMagic:",maxMagic,"\n\tSpeed:",maxSpeed)
	if charClass:
		ret += charClass.stringify()
	return ret
