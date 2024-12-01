extends Control

@onready var scene = $"."
@onready var audioMusic = $MusicAudioStreamPlayer
@onready var audioUI = $UIAudioStreamPlayer
@onready var victoryScreen = $"Level Won"
@onready var lossScreen = $"Loss Screen"

@export var klick1:AudioStream
@export var klick2:AudioStream
@export var hover:AudioStream
@export var scroll:AudioStream

func _ready():
	if Globals.victorious == true:
		victoryScreen.visible = true
		lossScreen.visible = false
	elif Globals.victorious == false:
		lossScreen.visible = true
		victoryScreen.visible = false



func _on_texture_button_next_level_2_pressed():
	audioUI.set_stream(klick1)
	audioUI.play()
	#SceneSwitcher.switch_scene(Globals.level_2)


func _on_texture_button_main_menu_pressed():
	audioUI.set_stream(klick1)
	audioUI.play()
	SceneSwitcher.switch_scene(Globals.mainMenu)


func _on_texture_button_quit_pressed():
	get_tree().quit()
