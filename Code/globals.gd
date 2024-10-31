extends Node

#TODO gunLeft, gunRight, legs

@export var test_Scene = "res://Maps/test_scene.tscn"
#TODO Scene 1 to final
var currentScene = test_Scene

var settings_save = "user://Settings.save"
var save_1 = "user://Slot1.save"
var save_2 = "user://Slot2.save"
var save_3 = "user://Slot3.save"
var current_save = save_1

var lmg_unlock = true
var minigun_unlock = true
var rocket_unlock = true

#TODO level unlock

var masterVolume:float
var musicVolume:float
var effectsVolume:float
var uiVolume:float

func saveGame():
	var file = FileAccess.open(current_save, FileAccess.WRITE)
	file.store_var(lmg_unlock)
	file.store_var(minigun_unlock)
	file.store_var(rocket_unlock)

func loadGame():
	if FileAccess.file_exists(current_save):
		var file = FileAccess.open(current_save, FileAccess.READ)
		lmg_unlock = file.get_var(lmg_unlock)
		minigun_unlock = file.get_var(minigun_unlock)
		rocket_unlock = file.get_var(rocket_unlock)

func settingsSave():
	masterVolume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	musicVolume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	effectsVolume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("effects"))
	uiVolume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("ui"))
	var file = FileAccess.open(settings_save, FileAccess.WRITE)
	file.store_var(masterVolume)
	file.store_var(musicVolume)
	file.store_var(effectsVolume)
	file.store_var(uiVolume)

func settingsLoad():
	var file = FileAccess.open(settings_save, FileAccess.READ)
	masterVolume = file.get_var(masterVolume)
	musicVolume = file.get_var(musicVolume)
	effectsVolume = file.get_var(effectsVolume)
	uiVolume = file.get_var(uiVolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),masterVolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),musicVolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("effects"),effectsVolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("ui"),uiVolume)
