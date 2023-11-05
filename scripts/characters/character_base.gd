extends AnimatedSprite2D

@export var UiNums : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start():
	play("idle")

func movement(delta):
	var lastPos = position
	
	var running = Input.is_action_pressed("run") && UiNums.stamina >= 1
	var moveSpeed = delta * (65 if running else 40)
	
	var moves = [
		[ "up",    Vector2.UP ],
		[ "down",  Vector2.DOWN ],
		[ "right", Vector2.RIGHT ],
		[ "left",  Vector2.LEFT ],
	]
	
	for move in moves:
		if (Input.is_action_pressed("move_" + move[0])):
			position += move[1] * moveSpeed
		
	if (lastPos != position):
		if (lastPos.x != position.x):
			scale = Vector2(-0.25, 0.25) if lastPos.x > position.x else Vector2(0.25, 0.25)
		if running: UiNums.stamina -= delta * 25
		play("running" if running else "walking")
	else:
		if (UiNums.stamina < 99.9): UiNums.stamina = clamp(UiNums.stamina + delta * 40, 0, 99.9)
		scale = Vector2(0.25, 0.25)
		play("idle")
