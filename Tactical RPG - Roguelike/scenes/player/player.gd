class_name Player
extends CharacterBody2D

@onready var board = %Board
var move_path: Array[Vector2i] = []
@export var movement_points: int
var is_moving = false
var accessible_cells: Array[Vector2i] = []

func _physics_process(_delta):
	move_to_target()

func _input(event: InputEvent):
	if event.is_action_pressed("left_click") and not is_moving:
		var mouse_position = board.to_local(board.local_to_map(get_global_mouse_position()))
		var player_position = board.to_local(board.local_to_map(global_position))
		
		if player_position == mouse_position:
			accessible_cells = board.flood_fill(player_position, movement_points)
			board.visualize_accessible_cells(accessible_cells)
	
	elif event.is_action_released("left_click") and not is_moving:
		var target_cell = board.local_to_map(board.get_global_mouse_position())
		
		if target_cell in accessible_cells:
			move_path = board.astar_grid.get_id_path(
				board.local_to_map(global_position),
				target_cell
			).slice(1)
		
			if move_path.size() > 0:
				is_moving = true
		board.clear_visualization()

func move_to_target():
	if move_path.size() == 0 or movement_points <= 0:
		return
	
	var target_position = board.map_to_local(move_path.front())
	global_position = global_position.move_toward(target_position, 2)
	
	if global_position == target_position:
		move_path.pop_front()
		movement_points -= 1
		
		if move_path.size() == 0:
			is_moving = false
