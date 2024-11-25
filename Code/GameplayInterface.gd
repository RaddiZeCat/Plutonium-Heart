extends Node

@onready var gun1 = $"../../../Body/Gun1"
@onready var gun2 = $"../../../Body/Gun2"

@onready var mech = $"../../.."
@onready var pauseMenu = $EquipmentMenu
@onready var root = get_tree().root
@onready var scene = root.get_child(root.get_child_count()-1)

enum GunState{SHIELD,LMG,MINIGUN,SHOTGUN,LAUNCHER}
@onready var gunStateL = mech.gunStateL
@onready var gunStateR = mech.gunStateR
enum LegState{BIPED,QUADRUPED,THREADS}
@onready var legState = mech.legState


func _input(event):
	if Input.is_action_just_pressed("pause"):
		if scene.get_tree().paused == false:
			scene.pause()
			pauseMenu.visible = true
		elif scene.get_tree().paused == true:
			scene.unpause()
			pauseMenu.visible = false
		#attach sceneCode to every Scene Root


func _on_shield_l_pressed():
	mech.setWeapon1(GunState.SHIELD)
	gun1.texture = load("res://Assets/Player/Guns1.png")
	gun1.flip_v = false


func _on_shield_r_pressed():
	mech.setWeapon2(GunState.SHIELD)
	gun2.texture = load("res://Assets/Player/Guns1.png")
	gun2.flip_v = true


func _on_lmgl_pressed():
	mech.setWeapon1(GunState.LMG)
	gun1.texture = load("res://Assets/Player/Guns2.png")
	gun1.flip_v = false


func _on_lmgr_pressed():
	mech.setWeapon2(GunState.LMG)
	gun2.texture = load("res://Assets/Player/Guns2.png")
	gun2.flip_v = true


func _on_minigun_l_pressed():
	mech.setWeapon1(GunState.MINIGUN)
	gun1.texture = load("res://Assets/Player/Guns3.png")
	gun1.flip_v = true


func _on_minigun_r_pressed():
	mech.setWeapon2(GunState.MINIGUN)
	gun2.texture = load("res://Assets/Player/Guns3.png")
	gun2.flip_v = false


func _on_rocket_l_pressed():
	mech.setWeapon1(GunState.LAUNCHER)
	gun1.texture = load("res://Assets/Player/Guns5.png")
	gun1.flip_v = true


func _on_rocket_r_pressed():
	mech.setWeapon2(GunState.LAUNCHER)
	gun2.texture = load("res://Assets/Player/Guns5.png")
	gun2.flip_v = false


func _on_biped_pressed():
	mech.setLegs(LegState.BIPED)


func _on_quadruped_pressed():
	mech.setLegs(LegState.QUADRUPED)


func _on_threads_pressed():
	mech.setLegs(LegState.THREADS)


func _on_reset_pressed():
	scene.unpause()
	get_tree().reload_current_scene()
