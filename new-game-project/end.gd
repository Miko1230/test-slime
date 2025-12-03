extends Area2D

signal rock_reached_end
func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: CharacterBody2D):
	print("plswork")
	await get_tree().create_timer(1.0).timeout
	if body is CharacterBody2D and body.is_in_group("rocks"):
		print("Rock")
		emit_signal("rock_reached_end") 
		var slime = get_tree().get_first_node_in_group("player")
		if slime.has_method("game_over"):
			slime.game_over()
 
