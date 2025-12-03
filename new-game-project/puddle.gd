extends Area2D

@export var restore_amount: int = -1

func _ready():

	body_entered.connect(_on_body_entered)

	add_to_group("puddles")

func _on_body_entered(body: CharacterBody2D):
	print("Something puddle: ", body.name)
	print("Body type: ", body.get_class())
	if body is CharacterBody2D and "player" in body.get_groups():
		print("it works")
		if body.has_method("restore_hp"):
			if restore_amount == -1:
				body.restore_hp_to_max()
