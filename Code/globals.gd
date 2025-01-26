extends Node

@export var test_Scene = "res://Maps/test_scene.tscn"
@export var level_0 = "res://Maps/tutorial.tscn"
@export var level_1 = "res://Maps/level_1.tscn"
@export var level_2 = "res://Maps/level_2.tscn"
@export var level_3 = "res://Maps/level_3.tscn"
@export var mainMenu = "res://Maps/main_menu.tscn"
@export var end_scene = "res://Maps/end_scene.tscn"
var level0 = "res://Maps/tutorial.tscn"
var level1 = "res://Maps/level_1.tscn"
var level2 = "res://Maps/level_2.tscn"
var level3 = "res://Maps/level_3.tscn"
var currentScene = level_1

var settings_save = "user://Settings.save"
var save_1 = "user://Slot1.save"
var save_2 = "user://Slot2.save"
var save_3 = "user://Slot3.save"
var current_save = save_1

var victorious = false

enum GunState{SHIELD,LMG,MINIGUN,SHOTGUN,LAUNCHER}
var gunLeft = GunState.LMG
var gunRight = GunState.SHIELD
enum LegState{BIPED,QUADRUPED,THREADS}
var legs = LegState.QUADRUPED

var minigun_unlock = false
var rocket_unlock = false
var legs_unlock:int = 1
var level_unlock:int = 1

var masterVolume:float
var musicVolume:float
var effectsVolume:float
var uiVolume:float

func _ready():
	if FileAccess.file_exists(settings_save):
		settingsLoad()

func saveGame():
	var file = FileAccess.open(current_save, FileAccess.WRITE)
	file.store_var(minigun_unlock)
	file.store_var(rocket_unlock)
	file.store_var(legs_unlock)
	file.store_var(level_unlock)

func loadGame():
	if FileAccess.file_exists(current_save):
		var file = FileAccess.open(current_save, FileAccess.READ)
		minigun_unlock = file.get_var(minigun_unlock)
		rocket_unlock = file.get_var(rocket_unlock)
		legs_unlock = file.get_var(legs_unlock)
		level_unlock = file.get_var(level_unlock)

func reset(save:String):
	current_save = save
	minigun_unlock = false
	rocket_unlock = false
	legs_unlock = 1
	level_unlock = 1
	saveGame()

func settingsSave():
	masterVolume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	musicVolume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	effectsVolume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Effects"))
	uiVolume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("UI"))
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
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"),effectsVolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("UI"),uiVolume)
