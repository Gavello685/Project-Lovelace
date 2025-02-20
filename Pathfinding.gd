extends TileMap

class_name Pathfinding

@onready var tilemap = $"."
var astargrid = AStarGrid2D.new()
const range_layer = 1
const path_layer = 2
const main_source = 2
const range_atlas_coords = Vector2i(3, 0)
const path_atlas_coords = Vector2i(3, 1)

const is_solid = "is_solid"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_layer(1)
	add_layer(2)
	setup_grid()

func setup_grid():
	astargrid.region = get_used_rect()
	astargrid.cell_size = Vector2i(32, 32)
	astargrid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astargrid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astargrid.update()
	for team in Global.units:
		for unit in team:
			astargrid.set_point_solid(Global.positionToGrid(unit.position))

func show_path(from: Vector2i, to: Vector2i):
	clear_layer(2)
	var path_taken: Array[Vector2i] = astargrid.get_id_path(from, to)
	for cell in path_taken:
		set_cell(path_layer, cell-Vector2i(1,1), main_source, path_atlas_coords)
		print(tilemap.get_cell_atlas_coords(0, cell))

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
		set_cell(range_layer, cell-Vector2i(1,1), main_source, range_atlas_coords)

func in_range(from: Vector2i, to: Vector2i, range: float) -> bool:
	return astargrid.get_id_path(from, to).size() <= range

func clear_paths():
	clear_layer(1)
	clear_layer(2)
	astargrid.clear()
	setup_grid()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
