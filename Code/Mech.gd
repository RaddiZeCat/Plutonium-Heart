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
@onready var cameraMarker = $CameraMarker2D
@export var cameraSpeed = 50

@export var bullet:PackedScene
@export var minibullet:PackedScene
@export var shotbullet:PackedScene
@export var rocket:PackedScene
@onready var shotL:PackedScene = bullet
@onready var shotR:PackedScene = rocket

enum GunState{SHIELD,LMG,MINIGUN,SHOTGUN,LAUNCHER}
var gunStateL = GunState.LMG
var gunStateR = GunState.LMG

func _physics_process(delta):
	var input_horizontal = Input.get_axis("move_left","move_right")
	var input_vertical = Input.get_axis("move_up","move_down")
	var input = Vector2(input_horizontal,input_vertical)
	velocity = input.normalized() * speed * speed_multiplyer
	move_and_slide()
	
	legs.look_at(mech.position + input)
	body.look_at(get_global_mouse_position())
	gun1.look_at(get_global_mouse_position())
	gun2.look_at(get_global_mouse_position())
	
	cameraMarker.position = lerp(cameraMarker.position,(get_local_mouse_position() - body.position)*0.2,cameraSpeed*delta)

func _input(event):
	if Input.is_action_just_pressed("shoot_1"):
		shoot1()
	if Input.is_action_just_pressed("shoot_2"):
		shoot2()
	
func shoot1():
	var l = shotL.instantiate()
	owner.add_child(l)
	l.transform = muzzle1.global_transform

func shoot2():
	var r = shotR.instantiate()
	owner.add_child(r)
	r.transform = muzzle2.global_transform

func setWeapon1():
	match gunStateL:
		GunState.SHIELD:
			pass
		GunState.LMG:
			shotL = bullet
		GunState.MINIGUN:
			shotL = minibullet
		GunState.SHOTGUN:
			shotL = shotbullet
		GunState.LAUNCHER:
			shotL = rocket
	pass

func setWeapon2():
	match gunStateR:
		GunState.SHIELD:
			pass
		GunState.LMG:
			shotR = bullet
		GunState.MINIGUN:
			shotR = minibullet
		GunState.SHOTGUN:
			shotR = shotbullet
		GunState.LAUNCHER:
			shotR = rocket
	pass
