extends Node2D
class_name CharacterBase

@export var bangPos : float = 1.0
@export var size : float = 1.0

var sprite : AnimatedSprite2D
var rigidbody : RigidBody2D

const annoyedTime = 1.0
var idleTimer = annoyedTime

var isActive = false
var turnLeft = false

func start():
	rigidbody = get_node("rigidbody")
	sprite = get_node("rigidbody/sprite")
	set_active(isActive)

func set_active(active):
	set_process(active)
	isActive = active
	print(name)
	if (active): BeatMachine.play_sound("characters/" + name + "/switch_to.wav")

func movement(delta):
	var lastPos = position
	
	var running = Input.is_action_pressed("run") # && UiNums.stamina >= 1
	var moveSpeed = delta * (75 if running else 50)

	var moves = [
		[ "up",    Vector2.UP    ],
		[ "down",  Vector2.DOWN  ],
		[ "right", Vector2.RIGHT ],
		[ "left",  Vector2.LEFT  ],
	]
	
	var moveDir = ""
	
	for move in moves:
		if (Input.is_action_pressed("move_" + move[0])):
			rigidbody.apply_force(move[1] * moveSpeed)
		if (Input.is_action_just_pressed("move_" + move[0])):
#			BeatMachine.play_sound("explode.ogg") # lol...
			var isTurn = ((abs(scale.x) == scale.x and move[0] == "left") || (abs(scale.x) != scale.x and move[0] == "right")) and (move[0] != "up" and move[0] != "down")
			if (isTurn or sprite.animation == "idle_forward" or (sprite.animation != "walking" && sprite.animation != "running")):
				sprite.play("start_walking", 2 if running else 1)
				
	
	
	if (lastPos != position):
		idleTimer = 0
		if (lastPos.x != position.x):
			turnLeft = (lastPos.x > position.x)
		
		scale.x = -size if turnLeft else size
#		if running: UiNums.stamina -= delta * 25
		if ((sprite.animation == "start_walking" && sprite.frame_progress >= 1) || (sprite.animation != "start_walking")): 
			sprite.play("running" if running else "walking")
	else:
#		if (UiNums.stamina < 99.9): UiNums.stamina = clamp(UiNums.stamina + delta * 40, 0, 99.9)
		if (idleTimer < annoyedTime):
			idleTimer += delta
			sprite.play("idle")
		else:
			if (sprite.frame_progress >= 1 || sprite.animation == "idle_forward"):
				scale.x = size
				sprite.play("idle_forward")
			else:
				sprite.play("idle_transition")
			
