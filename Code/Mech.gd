extends CharacterBody2D

@onready var mech = $"."
@onready var legs = $Legs
@onready var body = $Body
@onready var gun1 = $Body/Gun1
@onready var gun2 = $Body/Gun2
@onready var muzzle1 = $Body/Gun1/Marker2D1
@onready var muzzle2 = $Body/Gun2/Marker2D2
@export var speed:float = 30
@export var speed_multiplyer = 1

@export var bullet:PackedScene
@export var rocket:PackedScene

func _physics_process(delta):
	var input_horizontal = Input.get_axis("move_left","move_right")
	var input_vertical = Input.get_axis("move_up","move_down")
	var input = Vector2(input_horizontal,input_vertical)
	velocity = input.normalized() * speed * speed_multiplyer
	move_and_slide()
	
	legs.look_at(mech.position + input)
	
	body.look_at(get_global_mouse_position())
	

func _input(event):
	if Input.is_action_just_pressed("shoot_1"):
		shoot1()
	if Input.is_action_just_pressed("shoot_2"):
		shoot2()

func shoot1():
	var b = bullet.instantiate()
	owner.add_child(b)
	b.transform = muzzle1.global_transform

func shoot2():
	var r = rocket.instantiate()
	owner.add_child(r)
	r.transform = muzzle2.global_transform
