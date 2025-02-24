extends AnimatedSprite2D

@export var menu_parent_path: NodePath
@export var cursor_offset: Vector2
signal menu_cursor_moved(parent)

@onready var menu_parent:= get_node(menu_parent_path)

var cursor_index: int = 0

func _process(delta):
	var input := Vector2.ZERO
	
	if Input.is_action_just_pressed("up"):
		input.y -=1
	if Input.is_action_just_pressed("down"):
		input.y +=1
	if Input.is_action_just_pressed("left"):
		input.y -=1
	if Input.is_action_just_pressed("right"):
		input.y +=1
		
	if menu_parent is VBoxContainer:
		_set_cursor_from_index(cursor_index + input.y)

func _get_menu_item_at_index(index: int) -> Control:
	if menu_parent == null:
		return null
	
	if index >= menu_parent.get_child_count() or index < 0:
		return null
		
	return menu_parent.get_child(index) as Control
	
func _set_cursor_from_index(index: int) -> void:
	var menu_item:= _get_menu_item_at_index(index)
	
	if menu_item == null:
		return
		
	var position = menu_item.global_position
	var size = menu_item.size
	
	global_position = Vector2(position.x, position.y + size.y / 2) - (size / 2) - cursor_offset
	
	cursor_index = index
	menu_cursor_moved.emit(menu_parent)
