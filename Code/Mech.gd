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
@onready var gameplayInterface = $CameraMarker2D/Camera2D/GameplayInterface
@onready var e = $CameraMarker2D/Camera2D/GameplayInterface/E
@onready var explosiveDecal = load("res://Prefabs/explosion.tscn")
@onready var exploded = false

@export var bullet:PackedScene
@export var minibullet:PackedScene
@export var shotbullet:PackedScene
@export var rocket:PackedScene
@export var shieldShot:PackedScene
@onready var shotL:PackedScene = bullet
@onready var shotR:PackedScene = shieldShot
@onready var timerL = $TimerL
@onready var timerR = $TimerR
@onready var atMechanic = false
@onready var mechanicOpen = false
var uiOpen = true
var dead = false

enum GunState{SHIELD,LMG,MINIGUN,SHOTGUN,LAUNCHER}
var gunStateL = Globals.gunLeft
var gunStateR = Globals.gunRight
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
var legState = Globals.legs
@onready var legAnimator = $Legs/AnimationPlayer
var legIdle:String
var legWalk:String
var DamageMultiplyer

@onready var audioMech = $MechAudioStreamPlayer2D
@onready var audioGun1 = $Gun1AudioStreamPlayer2D
@onready var audioGun2 = $Gun2AudioStreamPlayer2D
@onready var audioPickup = $PickupAudioStreamPlayer2D
@export var audioShield:AudioStream
@export var audioLMG:AudioStream
@export var audioMinigun:AudioStream
@export var audioRocket:AudioStream
@export var charge:AudioStream
@export var stomp:AudioStream
@export var crush:AudioStream
@export var tankIdle:AudioStream
@export var tankDrive:AudioStream
var moving = false
@onready var motionChecker = $Sprite2D


func _ready():
	setWeapon1(gunStateL)
	setWeapon2(gunStateR)
	setLegs(legState)

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
		motionChecker.visible = true
	else:
		legAnimator.play(legIdle)
		motionChecker.visible = false
	
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
		
	if Input.is_action_just_pressed("toggleui"):
		if uiOpen == true:
			$CameraMarker2D/Camera2D/GameplayInterface.visible = false
			uiOpen = false
		elif uiOpen == false:
			$CameraMarker2D/Camera2D/GameplayInterface.visible = true
			uiOpen = true
		
	if Input.is_action_just_pressed("interact"):
		if atMechanic == true:
			if mechanicOpen == false:
				gameplayInterface.openMechanic()
				mechanicOpen = true
	
	if controllerLook != Vector2(0,0):
		usingController = true
	if event is InputEventMouseMotion:
		usingController = false

func shoot1():
	var l = shotL.instantiate()
	owner.add_child(l)
	l.friendly = true
	l.transform = muzzle1.global_transform
	var rng = RandomNumberGenerator.new()
	audioGun1.pitch_scale = rng.randf_range(0.8,1.2)
	audioGun1.play()

func shoot2():
	var r = shotR.instantiate()
	owner.add_child(r)
	r.friendly = true
	r.transform = muzzle2.global_transform
	var rng = RandomNumberGenerator.new()
	audioGun2.pitch_scale = rng.randf_range(0.8,1.2)
	audioGun2.play()

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

func step():
	var rng = RandomNumberGenerator.new()
	audioMech.pitch_scale = rng.randf_range(0.8,1.2)
	match legState:
		LegState.BIPED:
			audioMech.play()
		LegState.QUADRUPED:
			audioMech.play()
		LegState.THREADS:
			pass

func _on_sprite_2d_visibility_changed():
	match legState:
		LegState.THREADS:
			if motionChecker.visible == true:
				audioMech.set_stream(tankDrive)
				audioMech.play()
			else:
				audioMech.set_stream(tankIdle)
				audioMech.play()

func _on_mech_audio_stream_player_2d_finished():
	match legState:
		LegState.THREADS:
			audioMech.play()

func hit(damage):
	currentHealth -= (damage * DamageMultiplyer)
	healthBar.frame = currentHealth
	if currentHealth <= 0:
		game_over()
	pass

func heal(energy):
	currentHealth += energy
	if currentHealth > health:
		currentHealth = health
	healthBar.frame = currentHealth
	audioPickup.set_stream(charge)
	audioPickup.play()

func game_over():
	print("Game Over")
	dead = true
	Globals.victorious = false
	if exploded == false:
		exploded = true
		var i = explosiveDecal.instantiate()
		scene.get_root().add_child(i)
		i.transform = $".".global_transform
		$".".visible = false
	await get_tree().create_timer(2).timeout
	SceneSwitcher.switch_scene(Globals.end_scene)
	pass

func setWeapon1(gunStateL):
	match gunStateL:
		GunState.SHIELD:
			shotL = shieldShot
			waitL = 0.5
			audioGun1.set_stream(audioShield)
			gun1.texture = load("res://Assets/Player/Guns1.png")
			gun1.flip_v = false
		GunState.LMG:
			shotL = bullet
			waitL = 0.2
			audioGun1.set_stream(audioLMG)
			gun1.texture = load("res://Assets/Player/Guns2.png")
			gun1.flip_v = false
		GunState.MINIGUN:
			shotL = minibullet
			waitL = 0.1
			audioGun1.set_stream(audioMinigun)
			gun1.texture = load("res://Assets/Player/Guns3.png")
			gun1.flip_v = true
		GunState.SHOTGUN:
			shotL = shotbullet
			waitL = 0.5
		GunState.LAUNCHER:
			shotL = rocket
			waitL = 1
			audioGun1.set_stream(audioRocket)
			gun1.texture = load("res://Assets/Player/Guns5.png")
			gun1.flip_v = true
	pass

func setWeapon2(gunStateR):
	match gunStateR:
		GunState.SHIELD:
			shotR = shieldShot
			waitR = 0.5
			audioGun2.set_stream(audioShield)
			gun2.texture = load("res://Assets/Player/Guns1.png")
			gun2.flip_v = true
		GunState.LMG:
			shotR = bullet
			waitR = 0.2
			audioGun2.set_stream(audioLMG)
			gun2.texture = load("res://Assets/Player/Guns2.png")
			gun2.flip_v = true
		GunState.MINIGUN:
			shotR = minibullet
			waitR = 0.07
			audioGun2.set_stream(audioMinigun)
			gun2.texture = load("res://Assets/Player/Guns3.png")
			gun2.flip_v = false
		GunState.SHOTGUN:
			shotR = shotbullet
			waitR = 0.5
		GunState.LAUNCHER:
			shotR = rocket
			waitR = 2
			audioGun2.set_stream(audioRocket)
			gun2.texture = load("res://Assets/Player/Guns5.png")
			gun2.flip_v = false
	pass

func setLegs(newLegState):
	legState = newLegState
	match legState:
		LegState.BIPED:
			accelerationDuration = 2
			speed = 50
			legIdle = "LegsIdle"
			legWalk = "LegsWalk"
			DamageMultiplyer = 2
			audioMech.set_stream(stomp)
			audioMech.max_polyphony = 2
		LegState.QUADRUPED:
			accelerationDuration = 1
			speed = 35
			legIdle = "QuadIdle"
			legWalk = "QuadWalk"
			DamageMultiplyer = 1
			audioMech.set_stream(stomp)
			audioMech.max_polyphony = 2
		LegState.THREADS:
			accelerationDuration = 0.7
			speed = 25
			legIdle = "TrakIdle"
			legWalk = "TrakWalk"
			DamageMultiplyer = 0.5
			audioMech.set_stream(tankIdle)
			audioMech.max_polyphony = 1
			audioMech.play()





