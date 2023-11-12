extends AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_music(song : String, volume = 1.0, loop = true):
	var beat = AudioStreamPlayer.new()
	add_child(beat)
	beat.stream = load("res://assets/music/" + song)
	beat.volume_db = volume
	beat.play()

func play_sound(sfx : String, volume = 1.0, loop = false):
	var beat = AudioStreamPlayer.new()
	add_child(beat)
	beat.stream = load("res://assets/sfx/" + sfx)
	beat.volume_db = volume
	beat.play()
