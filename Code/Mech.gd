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
@export var cameraSpeed = 30

@export var bullet:PackedScene
@export var minibullet:PackedScene
@export var shotbullet:PackedScene
@export var rocket:PackedScene
@onready var shotL:PackedScene = bullet
@onready var shotR:PackedScene = rocket

enum GunState{SHIELD,LMG,MINIGUN,SHOTGUN,LAUNCHER}
var gunStateL = GunState.LMG
var gunStateR = GunState.LAUNCHER
var waitL = 0.2
var waitR = 1
var shootingL:bool
var shootingR:bool

func _ready():
	setWeapon1(gunStateL) #Globals.gunStateL
	setWeapon2(gunStateR) #Globals.gunStateR

func _physics_process(delta):
	var input_horizontal = Input.get_axis("move_left","move_right")
	var input_vertical = Input.get_axis("move_up","move_down")
	var input = Vector2(input_horizontal,input_vertical)
	velocity = input.normalized() * speed * speed_multiplyer
	move_and_slide()
	
	legs.look_at(mech.position + input)
	body.look_at(cameraMarker.global_position)
	gun1.look_at(get_global_mouse_position())
	gun2.look_at(get_global_mouse_position())
	cameraMarker.position = lerp(cameraMarker.position,(get_local_mouse_position() - body.position)*0.2,cameraSpeed*delta)

func _input(event):
	if Input.is_action_just_pressed("shoot_1"):
		shootingL = true
	if Input.is_action_just_released("shoot_1"):
		shootingL = false
	if Input.is_action_just_pressed("shoot_2"):
		shootingR = true
	if Input.is_action_just_released("shoot_2"):
		shootingR = false
	
func shoot1():
	var l = shotL.instantiate()
	owner.add_child(l)
	l.transform = muzzle1.global_transform

func shoot2():
	var r = shotR.instantiate()
	owner.add_child(r)
	r.transform = muzzle2.global_transform

func _process(delta):
	var pewL = true
	if shootingL == true:
		if pewL == true:
			await get_tree().create_timer(waitL).timeout
			pewL = false
		elif pewL == false:
			shoot1()
			pewL = true
	
	var pewR = false
	if shootingR == true:
		if pewR == true:
			pass
		else:
			pewR = true
			shoot2()
			await get_tree().create_timer(waitR).timeout
			pewR = false

func setWeapon1(gunStateL):
	match gunStateL:
		GunState.SHIELD:
			pass
		GunState.LMG:
			shotL = bullet
			waitL = 0.2
		GunState.MINIGUN:
			shotL = minibullet
			waitL = 0.1
		GunState.SHOTGUN:
			shotL = shotbullet
			waitL = 0.5
		GunState.LAUNCHER:
			shotL = rocket
			waitL = 1
	pass

func setWeapon2(gunStateR):
	match gunStateR:
		GunState.SHIELD:
			pass
		GunState.LMG:
			shotR = bullet
			waitR = 0.2
		GunState.MINIGUN:
			shotR = minibullet
			waitR = 0.1
		GunState.SHOTGUN:
			shotR = shotbullet
			waitR = 0.5
		GunState.LAUNCHER:
			shotR = rocket
			waitR = 1
	pass
