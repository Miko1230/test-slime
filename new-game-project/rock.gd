extends GridObject

@export var pushable: bool = true


func _ready():
	var start_cell = Vector2(2, 3) 
	target_grid_position = start_cell
	position = grid_to_world(start_cell) 
	snap_to_grid()
	add_to_group("rocks")  

func can_move_to_grid(grid_pos: Vector2) -> bool:
	if not pushable:
		return false
	

	var rocks = get_tree().get_nodes_in_group("rocks")
	for rock in rocks:
		if rock != self and rock.target_grid_position == grid_pos:
			return false  

	if is_wall_at_grid_position(grid_pos):
		return false
	
	return true

func is_wall_at_grid_position(grid_pos: Vector2) -> bool:
	var walls = get_tree().get_nodes_in_group("walls")
	for wall in walls:
		if wall.has_method("get_grid_position"):
			if wall.get_grid_position() == grid_pos:
				return true
	return false

func move_to_grid_direction(direction: Vector2) -> bool:
	var target_pos = target_grid_position + direction
	if not can_move_to_grid(target_pos):
		return false
	
	target_grid_position = target_pos

	var target_pixel_position = grid_to_world(target_grid_position)
	var tween = create_tween()
	tween.tween_property(self, "position", target_pixel_position, move_duration)
	
	return true
