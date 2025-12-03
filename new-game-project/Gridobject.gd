class_name GridObject
extends Node2D

@export var grid_size: int = 100
@export var move_duration: float = 0.2
var target_grid_position: Vector2
var is_moving: bool = false
@onready var area_2d: Area2D = $Area2D
func _ready():
	snap_to_grid()
	if area_2d:
		area_2d.area_entered.connect(_on_area_entered)
func _on_area_entered(area: Area2D):

	pass
func snap_to_grid():
	var current_grid_pos = world_to_grid(position)
	target_grid_position = current_grid_pos
	position = grid_to_world(current_grid_pos)

func move_to_grid_direction(direction: Vector2) -> bool:
	var new_grid_pos = target_grid_position + direction
	
	if can_move_to_grid(new_grid_pos):
		target_grid_position = new_grid_pos
		is_moving = true
		
		var target_pixel_position = grid_to_world(new_grid_pos)
		var tween = create_tween()
		tween.tween_property(self, "position", target_pixel_position, 0.2)
		tween.finished.connect(_on_move_finished)
		return true
	return false

func can_move_to_grid(grid_pos: Vector2) -> bool:
	return true

func grid_to_world(grid_pos: Vector2) -> Vector2:
	return grid_pos * grid_size

func world_to_grid(world_pos: Vector2) -> Vector2:
	return (world_pos / grid_size).round()

func _on_move_finished():
	position = grid_to_world(target_grid_position)
	is_moving = false
