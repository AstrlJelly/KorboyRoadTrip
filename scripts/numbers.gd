extends Node2D

@export var Numbers : Array[Texture2D]

@export var Num1 : Sprite2D
@export var Num2 : Sprite2D
 
@export var stamina = 99.9

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clamp(stamina, 0, 99)
	var stam = stamina as int
	Num1.texture = Numbers[(stam - stam % 10) / 10]
	Num2.texture = Numbers[stam % 10]
	# print("digit one = " + str((stam - stam % 10) / 10) + ", digit two = " + str(stam % 10))
	pass
