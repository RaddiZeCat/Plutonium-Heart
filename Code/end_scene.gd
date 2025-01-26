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
	audioMusic.play()
	if Globals.victorious == true:
		victoryScreen.visible = true
		lossScreen.visible = false
		$"Level Won/VBoxContainer/TextureButtonMainMenu".grab_focus()
	elif Globals.victorious == false:
		lossScreen.visible = true
		victoryScreen.visible = false
		$"Loss Screen/VBoxContainer/TextureButtonMainMenu".grab_ocus()


func _on_texture_button_next_level_2_pressed():
	audioUI.set_stream(klick1)
	audioUI.play()
	


func _on_texture_button_main_menu_pressed():
	audioUI.set_stream(klick1)
	audioUI.play()
	SceneSwitcher.switch_scene(Globals.mainMenu)


func _on_texture_button_quit_pressed():
	get_tree().quit()


func _on_music_audio_stream_player_finished():
	audioMusic.play()
