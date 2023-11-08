extends Node2D

var beat = load("res://assets/prefabs/managers/beat.tscn")
var test = "yay"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play(sfx, volume = 1.0):
	var bus_index := AudioServer.get_bus_count()
	AudioServer.add_bus(bus_index)
	AudioServer.set_bus_name(bus_index, "sfx")
	AudioServer.set_bus_send(bus_index, "Master") # <--

	var newBeat = beat.instantiate().get_children()[0]
	newBeat.stream = load("res://assets/sfx/" + sfx)
	newBeat.volume_db = volume
	newBeat.play()
	add_child(newBeat)
	return newBeat
