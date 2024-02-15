extends CharacterBody2D

class_name bot

@export var charName: String
@export var charClass: bot_stats
@export var level: int
@export var sprite: Sprite2D
@export var team: int
@export var startPos: Vector2
@export var shape: RectangleShape2D
@export var hitbox: CollisionShape2D

func _init(p_charName = "Default", p_charClass = "res://bot_stats.tres", p_level = 1, p_sprite = "res://icon.svg", p_team = 0, p_startPos = Vector2(0,0), p_shape = RectangleShape2D.new(), p_hitbox = CollisionShape2D.new()):
	self.charName = p_charName
	self.charClass = load(p_charClass)
	self.level = p_level
	self.sprite = Sprite2D.new()
	self.sprite.texture = load(p_sprite)
	self.add_child(sprite)
	self.team = p_team
	self.startPos = p_startPos
	self.shape = RectangleShape2D.new()
	self.shape.size = Vector2(1,1)
	self.hitbox = CollisionShape2D.new()
	self.hitbox.shape = shape
	self.add_child(hitbox)
	self.scale = Vector2(0.25,0.25)

func _ready():
	# Uses an implicit, duck-typed interface for any 'health'-compatible resources.
	if charClass:
		charClass._print()


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	#move_and_slide()
