class_name Board
extends TileMap

# Instance de AStarGrid2D
var astar_grid: AStarGrid2D

func _ready():
	# Initialisation et configuration de AStarGrid2D
	astar_grid = AStarGrid2D.new()
	astar_grid.region = Rect2i(get_used_rect().position, get_used_rect().end)
	astar_grid.cell_size = get_tileset().tile_size
	astar_grid.offset = get_tileset().tile_size
	astar_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()

func show_possible_moves(start: Vector2i, move_points: int):
	var accessible_cells = flood_fill(start, move_points)
	visualize_accessible_cells(accessible_cells)

func flood_fill(start: Vector2i, points: int) -> Array[Vector2i]:
	var accessible: Array[Vector2i] = []
	var frontier = [start]
	var cost_so_far = {}
	cost_so_far[start] = 0
	
	while frontier.size() > 0:
		var current = frontier.pop_front()
		
		for direction in [Vector2i(0, -1), Vector2i(0, 1), Vector2i(-1, 0), Vector2i(1, 0)]:
			var next = current + direction
			var new_cost = cost_so_far[current] + 1
			
			if is_in_bounds(next) and new_cost <= points and not cost_so_far.has(next):
				cost_so_far[next] = new_cost
				frontier.append(next)
				accessible.append(next)
	return accessible

func is_in_bounds(cell: Vector2i) -> bool:
	var in_bounds = astar_grid.region.has_point(cell)
	return in_bounds

func visualize_accessible_cells(cells: Array[Vector2i]):
	for cell in cells:
		set_cell(0, cell, 0, Vector2i(0, 0)) 

func clear_visualization():
	for x in range(astar_grid.region.size.x):
		for y in range(astar_grid.region.size.y):
			set_cell(0, Vector2i(x,y), 0, Vector2i(0, 3))  
