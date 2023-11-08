extends Node2D

@export var anSp : AnimatedSprite2D
@export var size : float = 1.0
@export var sfxs : Dictionary

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
	
	var running = Input.is_action_pressed("run") # && UiNums.stamina >= 1
	var moveSpeed = delta * (75 if running else 40)

	var moves = [
		[ "up",    Vector2.UP    ],
		[ "down",  Vector2.DOWN  ],
		[ "right", Vector2.RIGHT ],
		[ "left",  Vector2.LEFT  ],
	]
	
	var moveDir = ""
	
	for move in moves:
		if (Input.is_action_pressed("move_" + move[0])):
			position += move[1] * moveSpeed
		if (Input.is_action_just_pressed("move_" + move[0])):
#			BeatMachine.play(sfxs["explode"])
			var isTurn = (abs(scale.x) == scale.x and move[0] == "left") || (abs(scale.x) != scale.x && move[0] == "right")
			if (isTurn && anSp.animation != "walking" && anSp.animation != "running"):
				anSp.play("start_walking", 2 if running else 1)
				
	
	
	if (lastPos != position):
		idleTimer = 0
		if (lastPos.x != position.x):
			scale.x = -size if lastPos.x > position.x else size
#		if running: UiNums.stamina -= delta * 25
		if ((anSp.animation == "start_walking" && anSp.frame_progress >= 1) || (anSp.animation != "start_walking")): 
			anSp.play("running" if running else "walking")
	else:
#		if (UiNums.stamina < 99.9): UiNums.stamina = clamp(UiNums.stamina + delta * 40, 0, 99.9)
		if (idleTimer < 1):
			idleTimer += delta
			anSp.play("idle")
		else:
			if (anSp.frame_progress >= 1 || anSp.animation == "idle_forward"):
				anSp.play("idle_forward")
			else:
				anSp.play("idle_transition")
			
