extends AnimatedSprite2D

@export var UiNums : Node2D

var size = 1

var idleTimer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start():
	pass

func movement(delta):
	var lastPos = position
	
	var running = Input.is_action_pressed("run") && UiNums.stamina >= 1
	var moveSpeed = delta * (75 if running else 40)

	var moves = [
		[ "up",    Vector2.UP    ],
		[ "down",  Vector2.DOWN  ],
		[ "right", Vector2.RIGHT ],
		[ "left",  Vector2.LEFT  ],
	]
	
	for move in moves:
		if (Input.is_action_pressed("move_" + move[0])):
			position += move[1] * moveSpeed
		if (Input.is_action_just_pressed("move_" + move[0])):
			var isTurn = (abs(scale.x) == scale.x and move[0] == "left") || (abs(scale.x) != scale.x && move[0] == "right")
			if (isTurn && animation != "walking" && animation != "running"):
				play("start_walking", 2 if running else 1)
		
	if (lastPos != position):
		idleTimer = 0
		if (lastPos.x != position.x):
			scale.x = -size if lastPos.x > position.x else size
		if running: UiNums.stamina -= delta * 25
		if ((animation == "start_walking" && frame_progress >= 1) || (animation != "start_walking")): 
			play("running" if running else "walking")
	else:
		if (UiNums.stamina < 99.9): UiNums.stamina = clamp(UiNums.stamina + delta * 40, 0, 99.9)
		if (idleTimer < 5):
			idleTimer += delta
			play("idle")
		else:
			if (frame_progress >= 1 || animation == "idle_forward"):
				play("idle_forward")
			else:
				play("idle_transition")
			
