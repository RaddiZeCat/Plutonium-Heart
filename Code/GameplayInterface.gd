extends Node

@onready var gun1 = $"../../../Body/Gun1"
@onready var gun2 = $"../../../Body/Gun2"

@onready var mech = $"../../.."
@onready var pauseMenu = $EquipmentMenu
@onready var optionsMenu = $OptionsMenu
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

func _ready():
	$OptionsMenu/HBoxContainer/VBoxContainer/HSliderMain.set("value",AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$OptionsMenu/HBoxContainer/VBoxContainer/HSliderMusic.set("value",AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	$OptionsMenu/HBoxContainer/VBoxContainer/HSliderEffects.set("value",AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Effects")))
	$OptionsMenu/HBoxContainer/VBoxContainer/HSliderUI.set("value",AudioServer.get_bus_volume_db(AudioServer.get_bus_index("UI")))
	if Globals.minigun_unlock == true:
		$EquipmentMenu/MechImage/MinigunL.disabled = false
		$EquipmentMenu/MechImage/MinigunR.disabled = false
	else:
		$EquipmentMenu/MechImage/MinigunL.disabled = true
		$EquipmentMenu/MechImage/MinigunR.disabled = true
	if Globals.rocket_unlock == true:
		$EquipmentMenu/MechImage/RocketL.disabled = false
		$EquipmentMenu/MechImage/RocketR.disabled = false
	else:
		$EquipmentMenu/MechImage/RocketL.disabled = true
		$EquipmentMenu/MechImage/RocketR.disabled = true
	if Globals.legs_unlock == 1:
		$EquipmentMenu/MechImage/Biped.disabled = true
		$EquipmentMenu/MechImage/Quadruped.disabled = false
		$EquipmentMenu/MechImage/Threads.disabled = true
	elif Globals.legs_unlock == 2:
		$EquipmentMenu/MechImage/Biped.disabled = false
		$EquipmentMenu/MechImage/Quadruped.disabled = false
		$EquipmentMenu/MechImage/Threads.disabled = true
	elif Globals.legs_unlock == 3:
		$EquipmentMenu/MechImage/Biped.disabled = false
		$EquipmentMenu/MechImage/Quadruped.disabled = false
		$EquipmentMenu/MechImage/Threads.disabled = false

func _input(event):
	if Input.is_action_just_pressed("pause"):
		if scene.get_tree().paused == false:
			klick2()
			scene.pause()
			optionsMenu.visible = true #change to optionsMenu insted of pauseMenu
			$EquipmentMenu/MechImage/ShieldL.grab_focus()
		elif scene.get_tree().paused == true:
			scene.unpause()
			klick2()
			optionsMenu.visible = false #change it here too
		#attach sceneCode to every Scene Root

func openMechanic():
	pauseMenu.visible = true
	scene.pause()
	klick2()
	$OptionsMenu/HBoxContainer/VBoxContainer3/TextureButtonBack2.grab_focus()

func closeMechanic():
	pauseMenu.visible = false
	scene.unpause()
	klick2()

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


#region EquipmentUI


func _on_shield_l_pressed():
	mech.setWeapon1(GunState.SHIELD)
	Globals.gunLeft = GunState.SHIELD
	klick()


func _on_shield_r_pressed():
	mech.setWeapon2(GunState.SHIELD)
	Globals.gunRight = GunState.SHIELD
	klick()


func _on_lmgl_pressed():
	mech.setWeapon1(GunState.LMG)
	Globals.gunLeft = GunState.LMG
	klick()


func _on_lmgr_pressed():
	mech.setWeapon2(GunState.LMG)
	Globals.gunRight = GunState.LMG
	klick()


func _on_minigun_l_pressed():
	mech.setWeapon1(GunState.MINIGUN)
	Globals.gunLeft = GunState.MINIGUN
	klick()


func _on_minigun_r_pressed():
	mech.setWeapon2(GunState.MINIGUN)
	Globals.gunRight = GunState.MINIGUN
	klick()


func _on_rocket_l_pressed():
	mech.setWeapon1(GunState.LAUNCHER)
	Globals.gunLeft = GunState.LAUNCHER
	klick()


func _on_rocket_r_pressed():
	mech.setWeapon2(GunState.LAUNCHER)
	Globals.gunRight = GunState.LAUNCHER
	klick()


func _on_biped_pressed():
	mech.setLegs(LegState.BIPED)
	Globals.legs = LegState.BIPED
	klick()


func _on_quadruped_pressed():
	mech.setLegs(LegState.QUADRUPED)
	Globals.legs = LegState.QUADRUPED
	klick()


func _on_threads_pressed():
	mech.setLegs(LegState.THREADS)
	Globals.legs = LegState.THREADS
	klick()


func _on_reset_pressed(): #TODO Replace with better Options
	scene.unpause()
	Globals.settingsSave()
	get_tree().reload_current_scene()
	klick()


func _on_menu_pressed():
	klick()
	scene.unpause()
	Globals.settingsSave()
	SceneSwitcher.switch_scene(Globals.mainMenu)

func _on_back_pressed():
	klick()
	scene.unpause()
	Globals.settingsSave()
	pauseMenu.visible = false
	mech.mechanicOpen = false


func _on_quit_pressed():
	get_tree().quit()
#endregion

#region Hovers

func _on_shield_l_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_shield_r_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_lmgl_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_lmgr_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_minigun_l_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_minigun_r_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_rocket_l_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_rocket_r_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_biped_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_quadruped_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_threads_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_reset_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_menu_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_back_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_quit_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_texture_button_back_2_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_h_slider_main_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_h_slider_music_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_h_slider_effects_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()


func _on_h_slider_ui_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(audioHover)
		audioUI.play()
#endregion

func _on_texture_button_back_2_pressed():
	scene.unpause()
	klick2()
	Globals.settingsSave()
	optionsMenu.visible = false

func _on_texture_button_menu_pressed():
	klick()
	scene.unpause()
	Globals.settingsSave()
	SceneSwitcher.switch_scene(Globals.mainMenu)


func _on_h_slider_main_value_changed(value):
	audioUI.set_stream(audioScroll)
	audioUI.play()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),value)


func _on_h_slider_music_value_changed(value):
	audioUI.set_stream(audioScroll)
	audioUI.play()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),value)


func _on_h_slider_effects_value_changed(value):
	audioUI.set_stream(audioScroll)
	audioUI.play()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"),value)


func _on_h_slider_ui_value_changed(value):
	audioUI.set_stream(audioScroll)
	audioUI.play()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("UI"),value)



