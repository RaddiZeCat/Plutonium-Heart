extends CharacterBody2D

@export var speed = 10
@onready var legs = $Sprite2D
@onready var body = $Sprite2D2
@onready var gun1 = $Sprite2D3
@onready var gun2 = $Sprite2D4
@onready var mech = $"."

func _physics_process(delta):
	var input_horizontal = Input.get_axis("move_left","move_right")
	var input_vertical = Input.get_axis("move_up","move_down")
	var input = Vector2(input_horizontal,input_vertical)
	
	velocity = input.normalized() * speed
	move_and_slide()
	
	legs.look_at(mech.position + input)
	body.look_at(get_global_mouse_position())
