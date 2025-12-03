
extends Node2D 
func _ready():

	$Slime.game_over_signal.connect(_on_game_over)
	

	$End.rock_reached_end.connect(_on_rock_reached_end)

func _on_game_over(reason: String):
	print("Game Over: ", reason)
	get_tree().paused = true


func _on_rock_reached_end():
	$Slime.game_over()
