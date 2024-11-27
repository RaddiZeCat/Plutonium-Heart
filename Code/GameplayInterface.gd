extends Node

@onready var gun1 = $"../../../Body/Gun1"
@onready var gun2 = $"../../../Body/Gun2"

@onready var mech = $"../../.."
@onready var pauseMenu = $EquipmentMenu
@onready var root = get_tree().root
@onready var scene = root.get_child(root.get_child_count()-1)

@onready var audioUI = $"../../../UIAudioStreamPlayer2D"
@export var audioKlick:AudioStream
@export var audioKlick2:AudioStream
@export var audioHover:AudioStream
@export var audioScroll:AudioStream

enum GunState{SHIELD,LMG,MINIGUN,SHOTGUN,LAUNCHER}
@onready var gunStateL = mech.gunStateL
@onready var gunStateR = mech.gunStateR
enum LegState{BIPED,QUADRUPED,THREADS}
@onready var legState = mech.legState

func _input(event):
	if Input.is_action_just_pressed("pause"):
		if scene.get_tree().paused == false:
			klick2()
			scene.pause()
			pauseMenu.visible = true
			$EquipmentMenu/MechImage/ShieldL.grab_focus()
		elif scene.get_tree().paused == true:
			scene.unpause()
			klick2()
			pauseMenu.visible = false
		#attach sceneCode to every Scene Root

func klick():
	audioUI.set_stream(audioKlick)
	audioUI.play()

func klick2():
	audioUI.set_stream(audioKlick2)
	audioUI.play()

func hover():
	audioUI.set_stream(audioHover)
	audioUI.play()

func scroll():
	audioUI.set_stream(audioScroll)
	audioUI.play()

func _on_shield_l_pressed():
	mech.setWeapon1(GunState.SHIELD)
	gun1.texture = load("res://Assets/Player/Guns1.png")
	gun1.flip_v = false
	klick()


func _on_shield_r_pressed():
	mech.setWeapon2(GunState.SHIELD)
	gun2.texture = load("res://Assets/Player/Guns1.png")
	gun2.flip_v = true
	klick()


func _on_lmgl_pressed():
	mech.setWeapon1(GunState.LMG)
	gun1.texture = load("res://Assets/Player/Guns2.png")
	gun1.flip_v = false
	klick()


func _on_lmgr_pressed():
	mech.setWeapon2(GunState.LMG)
	gun2.texture = load("res://Assets/Player/Guns2.png")
	gun2.flip_v = true
	klick()


func _on_minigun_l_pressed():
	mech.setWeapon1(GunState.MINIGUN)
	gun1.texture = load("res://Assets/Player/Guns3.png")
	gun1.flip_v = true
	klick()


func _on_minigun_r_pressed():
	mech.setWeapon2(GunState.MINIGUN)
	gun2.texture = load("res://Assets/Player/Guns3.png")
	gun2.flip_v = false
	klick()


func _on_rocket_l_pressed():
	mech.setWeapon1(GunState.LAUNCHER)
	gun1.texture = load("res://Assets/Player/Guns5.png")
	gun1.flip_v = true
	klick()


func _on_rocket_r_pressed():
	mech.setWeapon2(GunState.LAUNCHER)
	gun2.texture = load("res://Assets/Player/Guns5.png")
	gun2.flip_v = false
	klick()


func _on_biped_pressed():
	mech.setLegs(LegState.BIPED)
	klick()


func _on_quadruped_pressed():
	mech.setLegs(LegState.QUADRUPED)
	klick()


func _on_threads_pressed():
	mech.setLegs(LegState.THREADS)
	klick()


func _on_reset_pressed(): #TODO Replace with better Options
	scene.unpause()
	get_tree().reload_current_scene()
