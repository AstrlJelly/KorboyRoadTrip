extends "res://scripts/characters/character_base.gd"



# Called when the node enters the scene tree for the first time.
func _ready():
	size = 0.25
	start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement(delta)
