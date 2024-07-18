extends TileMap

class_name Pathfinding

var astargrid = AStarGrid2D.new()
const main_layer = 1
const main_source = 1
const path_taken_atlas_coords = Vector2i(0, 0)

const is_solid = "is_solid"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_layer(1)
	setup_grid()

func setup_grid():
	astargrid.region = Rect2i(0, 0, 12, 8)
	astargrid.cell_size = Vector2i(32, 32)
	astargrid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astargrid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astargrid.update()
	for unit in Global.units:
		astargrid.set_point_solid(Global.positionToGrid(unit.position))

func show_range(from: Vector2i, range: float):
	var path_taken: Array[Vector2i]
	for x in range(astargrid.region.end.x):
		for y in range(astargrid.region.end.y):
			var tempRange = astargrid.get_id_path(from, Vector2i(x,y))
			if tempRange.size() <= range:
				for point in tempRange:
					if !path_taken.has(point):
						path_taken.append(point)
	for cell in path_taken:
		set_cell(main_layer, cell, main_source, path_taken_atlas_coords)

func in_range(from: Vector2i, to: Vector2i, range: float) -> bool:
	return astargrid.get_id_path(from, to).size() <= range

func clear_range():
	clear_layer(1)
	astargrid.clear()
	setup_grid()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
