extends CharacterBody2D
class_name CharacterBase

@export var bangPos : float = 1.0
@export var size : float = 1.0
@export var gravity = 50.0
@export var walkSpeed = 50.0
@export var runSpeed = 100.0

var sprite : AnimatedSprite2D
var character : CharacterBody2D

const annoyedTime = 1.0
var idleTimer = 0.0

var turnLeft = false

const moves = [
	[ "up",    Vector2.UP    ],
	[ "down",  Vector2.DOWN  ],
	[ "right", Vector2.RIGHT ],
	[ "left",  Vector2.LEFT  ],
]

func start():
	idleTimer = annoyedTime
	scale = Vector2.ONE * size
	sprite = get_node("sprite")


func set_active(active):
	set_process(active)
	if (active): BeatMachine.play_sound("characters/" + name + "/switch_to.wav")

func movement(delta):
	globalDelta = delta
	var lastPos = position

	running = Input.is_action_pressed("run") # && UiNums.stamina >= 1

	var moveDir = ""
	
#	if (!is_on_floor()):
	velocity.y += gravity * delta
	
	var left := Input.is_action_pressed("move_left")
	var right := Input.is_action_pressed("move_right")
	if ((left and not right) or (not left and right)):
		moving(left)
	else:
		stop_moving()
	
#	if (Input.is_action_just_pressed("move_" + move[0])):
##			BeatMachine.play_sound("explode.ogg") # lol...
#		var isTurn = ((abs(scale.x) == scale.x and move[0] == "left") || (abs(scale.x) != scale.x and move[0] == "right")) and (move[0] != "up" and move[0] != "down")
#		if (isTurn or sprite.animation == "idle_long" or (sprite.animation != "walking" && sprite.animation != "running")):
#			sprite.play("start_walking", 2 if running else 1)

	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		print("I collided with ", collision.get_collider().name)

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
			idle()
		else: annoyed()

var globalDelta : float
var running : bool

func start_moving(move):
	sprite.play("running" if running else "walking")
	
func moving(left):
	velocity.x = (-1 if left else 1) * (runSpeed if running else walkSpeed)
	print(velocity.x)

func stop_moving():
	velocity.x = 0

func idle():
	idleTimer += globalDelta
	sprite.play("idle")
	
func annoyed():
	if (sprite.frame_progress >= 1 || sprite.animation == "idle_long"):
		scale.x = size
		sprite.play("idle_long")
	else:
		sprite.play("idle_long_from_idle")
	
