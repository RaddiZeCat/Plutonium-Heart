extends CharacterBody2D

@onready var scene = get_tree()
@onready var mech = $"."
@onready var legs = $Legs
@onready var body = $Body
@onready var gun1 = $Body/Gun1
@onready var gun2 = $Body/Gun2
@onready var muzzle1 = $Body/Gun1/Marker2D1
@onready var muzzle2 = $Body/Gun2/Marker2D2
@onready var speed:float = 30
@onready var accelerationDuration = 1
@onready var cameraMarker = $CameraMarker2D
@export var cameraSpeed = 30
@export var health:int = 20
@onready var currentHealth:int = health
@onready var healthBar = $CameraMarker2D/Camera2D/GameplayInterface/Healthbar

@export var bullet:PackedScene
@export var minibullet:PackedScene
@export var shotbullet:PackedScene
@export var rocket:PackedScene
@onready var shotL:PackedScene = bullet
@onready var shotR:PackedScene = rocket
@onready var timerL = $TimerL
@onready var timerR = $TimerR

enum GunState{SHIELD,LMG,MINIGUN,SHOTGUN,LAUNCHER}
var gunStateL = GunState.LMG
var gunStateR = GunState.LAUNCHER
var waitL = 0.2
var waitR = 1
var shootingL:bool
var shootingR:bool

var usingController:bool = false
var controllerLook:Vector2

@export var accelerationCurve:Curve
@export var decelerationCurve:Curve
var accelerationTime:float = 0.0
var decelerationTime:float = 0.0
enum LegState{BIPED,QUADRUPED,THREADS}
var legState = LegState.QUADRUPED
@onready var legAnimator = $Legs/AnimationPlayer
var legIdle:String
var legWalk:String
var DamageMultiplyer

func _ready():
	setWeapon1(gunStateL) #TODO Globals.gunStateL
	setWeapon2(gunStateR) #TODO Globals.gunStateR
	setLegs(legState) #TODO Globals.legState

func _physics_process(delta):
	var input_horizontal = Input.get_axis("move_left","move_right")
	var input_vertical = Input.get_axis("move_up","move_down")
	var input = Vector2(input_horizontal,input_vertical)
	
	var controllerInput_horizontal = Input.get_axis("look_left","look_right")
	var controllerInput_Vertical = Input.get_axis("look_up","look_down")
	controllerLook = Vector2(controllerInput_horizontal,controllerInput_Vertical)
	
	var currentSpeed = speed
	if(input != Vector2.ZERO):
		decelerationTime = 0.0
		accelerationTime += delta * accelerationDuration
		currentSpeed = accelerationCurve.sample(accelerationTime)
		velocity = input.normalized() * speed * currentSpeed
	else:
		accelerationTime = 0.0
		decelerationTime += delta * (accelerationDuration * 2)
		currentSpeed = decelerationCurve.sample(decelerationTime)
		velocity = velocity * currentSpeed
	
	move_and_slide()
	
	if(input != Vector2.ZERO):
		legAnimator.play(legWalk)
	else:
		legAnimator.play(legIdle)
	
	legs.look_at(mech.position + input)
	body.look_at(cameraMarker.global_position)
	if usingController == false:
		gun1.look_at(get_global_mouse_position())
		gun2.look_at(get_global_mouse_position())
		cameraMarker.position = lerp(cameraMarker.position,(get_local_mouse_position() - body.position)*0.2,cameraSpeed*delta)
	elif usingController == true:
		if controllerLook != Vector2(0,0):
			gun1.look_at(body.global_position + controllerLook * 1000)
			gun2.look_at(body.global_position + controllerLook * 1000)
		cameraMarker.position = lerp(cameraMarker.position,((controllerLook * 100) - body.position)*0.2,cameraSpeed*delta)

func _input(event):
	if Input.is_action_just_pressed("shoot_1"):
		shootingL = true
	if Input.is_action_just_released("shoot_1"):
		shootingL = false
	if Input.is_action_just_pressed("shoot_2"):
		shootingR = true
	if Input.is_action_just_released("shoot_2"):
		shootingR = false
		
	if controllerLook != Vector2(0,0):
		usingController = true
	if event is InputEventMouseMotion:
		usingController = false

func shoot1():
	var l = shotL.instantiate()
	owner.add_child(l)
	l.transform = muzzle1.global_transform

func shoot2():
	var r = shotR.instantiate()
	owner.add_child(r)
	r.transform = muzzle2.global_transform

func _process(delta):
	if shootingL == true:
		if timerL.time_left > 0.0:
			return
		else:
			shoot1()
			timerL.start(waitL)
	
	if shootingR == true:
		if timerR.time_left > 0.0:
			return
		else:
			shoot2()
			timerR.start(waitR)

func hit(damage):
	currentHealth -= (damage * DamageMultiplyer)
	healthBar.frame = currentHealth
	if currentHealth <= 0:
		game_over()
	pass

func game_over():
	print("Game Over")
	SceneSwitcher.switch_scene(Globals.currentScene)
	pass

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
			waitR = 0.07
		GunState.SHOTGUN:
			shotR = shotbullet
			waitR = 0.5
		GunState.LAUNCHER:
			shotR = rocket
			waitR = 2
	pass

func setLegs(legState):
	match legState:
		LegState.BIPED:
			accelerationDuration = 2
			speed = 50
			legIdle = "LegsIdle"
			legWalk = "LegsWalk"
			DamageMultiplyer = 2
		LegState.QUADRUPED:
			accelerationDuration = 1
			speed = 30
			legIdle = "QuadIdle"
			legWalk = "QuadWalk"
			DamageMultiplyer = 1
		LegState.THREADS:
			accelerationDuration = 0.7
			speed = 20
			legIdle = "TrakIdle"
			legWalk = "TrakWalk"
			DamageMultiplyer = 0.5

