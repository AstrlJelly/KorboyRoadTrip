extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	print("test")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2.DOWN * delta * 100
	pass
