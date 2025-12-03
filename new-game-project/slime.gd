extends GridObject
signal game_over_signal(reason: String)
@export var max_hp: int = 100

var current_hp: int


func _ready():
	add_to_group("player")  
	current_hp = max_hp
	
	
	super._ready()
	
	
	var start_cell = Vector2(0, 0) 
	target_grid_position = start_cell
	position = grid_to_world(start_cell)

func _process(_delta):
	
	if is_moving:
		return
	
	var direction = Vector2.ZERO
	
	if Input.is_action_just_pressed("ui_right"):
		direction = Vector2.RIGHT
	elif Input.is_action_just_pressed("ui_left"):
		direction = Vector2.LEFT
	elif Input.is_action_just_pressed("ui_down"):
		direction = Vector2.DOWN
	elif Input.is_action_just_pressed("ui_up"):
		direction = Vector2.UP
	
	if direction != Vector2.ZERO:
		try_move(direction)
func try_move(direction: Vector2):
	var new_grid_pos = target_grid_position + direction
	

	var rock = get_rock_at_grid_position(new_grid_pos)
	
	if rock != null:
		
		if rock.move_to_grid_direction(direction):
			complete_player_move(direction)
	else:
		
		if can_move_to_grid(new_grid_pos):
			if(TileData.get_custom_data_by_layer_id(layer.id:1)==true):
				
			complete_player_move(direction)
		else: 
			print("sciana")

func complete_player_move(direction: Vector2):
	
	#current_hp -= 1
	print("HP: ", current_hp, "/", max_hp)
	
	if current_hp <= 0:
		game_over()
		return
	
	
	var success = move_to_grid_direction(direction)
	
	if success:
		
		pass

func get_rock_at_grid_position(grid_pos: Vector2) -> Node:
	var rocks = get_tree().get_nodes_in_group("rocks")
	for rock in rocks:
		if rock.target_grid_position == grid_pos:
			return rock
	return null


func can_move_to_grid(grid_pos: Vector2) -> bool:
	
	if not super.can_move_to_grid(grid_pos):
		return false
	
	
	
	
	return true



func game_over():
	print("Game Over!")
	emit_signal("game_over_signal")



func restore_hp(amount: int):
	current_hp += amount

	current_hp = min(current_hp, max_hp)
	print("HP restored! Current HP: ", current_hp, "/", max_hp)
	
func restore_hp_to_max():
	current_hp = max_hp
	print("HP fully restored! Current HP: ", current_hp, "/", max_hp)
