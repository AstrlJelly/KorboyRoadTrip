extends Node

@export var nums : Node2D

var characters : Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready():
	characters = get_children()
	characters[0].set_active(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode >= KEY_0 and event.keycode <= KEY_9:
			var key = event.keycode - KEY_0 - 1
			if (key > characters.size()):
				print("ermm.... meowkay.")
				return
			var i = 0
			for char in characters:
				nums.set_nums(key + 1)
				char.set_active(i == key)
				i += 1
