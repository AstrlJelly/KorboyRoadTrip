extends "res://scripts/characters/character_base.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	super.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	movement(delta)

func start_moving(move):
	var isTurn = ((abs(scale.x) == scale.x and move[0] == "left") || (abs(scale.x) != scale.x and move[0] == "right")) and (move[0] != "up" and move[0] != "down")
	if (isTurn or sprite.animation == "idle_forward" or (sprite.animation != "walking" && sprite.animation != "running")):
		sprite.play("walk_from_idle", 2 if running else 1)

#func moving(move):
#	sprite.play("running_1" if running else "walking")
#	character.velocity = globalDelta * (75 if running else 50) * move[1]
#	character.move_and_slide()
