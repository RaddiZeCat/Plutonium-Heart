extends Control

@onready var Scene = $"."
@onready var mainMenu = $MainMenu
@onready var playMenu = $PlayMenu
@onready var optionsMenu = $OptionsMenu
@onready var creditsMenu = $CreditsMenu
@onready var audioMusic = $MusicAudioStreamPlayer
@onready var audioUI = $UIAudioStreamPlayer

@export var klick1:AudioStream
@export var klick2:AudioStream
@export var hover:AudioStream
@export var scroll:AudioStream

func _ready():
	$OptionsMenu/HBoxContainer/VBoxContainer/HSliderMain.set("value",AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$OptionsMenu/HBoxContainer/VBoxContainer/HSliderMusic.set("value",AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	$OptionsMenu/HBoxContainer/VBoxContainer/HSliderEffects.set("value",AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Effects")))
	$OptionsMenu/HBoxContainer/VBoxContainer/HSliderUI.set("value",AudioServer.get_bus_volume_db(AudioServer.get_bus_index("UI")))
	$MainMenu/VBoxContainer/TextureButtonPlay.grab_focus()

func _input(event):
	if Input.is_action_just_pressed("ui_left"):
		audioUI.set_stream(hover)
		audioUI.play()
	elif Input.is_action_just_pressed("ui_right"):
		audioUI.set_stream(hover)
		audioUI.play()
	elif Input.is_action_just_pressed("ui_up"):
		audioUI.set_stream(hover)
		audioUI.play()
	elif Input.is_action_just_pressed("ui_down"):
		audioUI.set_stream(hover)
		audioUI.play()

#region Clicks
func _on_texture_button_play_pressed():
	mainMenu.visible = false
	playMenu.visible = true
	audioUI.set_stream(klick1)
	audioUI.play()
	$PlayMenu/VBoxContainer/TextureButtonSave1.grab_focus()


func _on_texture_button_options_pressed():
	mainMenu.visible = false
	optionsMenu.visible = true
	audioUI.set_stream(klick1)
	audioUI.play()
	$OptionsMenu/HBoxContainer/VBoxContainer3/TextureButtonBack2.grab_focus()


func _on_texture_button_credits_pressed():
	mainMenu.visible = false
	creditsMenu.visible = true
	audioUI.set_stream(klick1)
	audioUI.play()
	$CreditsMenu/VBoxContainer/TextureButtonBack3.grab_focus()


func _on_texture_button_quit_pressed():
	get_tree().quit()


func _on_texture_button_save_1_pressed():
	audioUI.set_stream(klick1)
	audioUI.play()
	Globals.current_save = Globals.save_1
	Globals.loadGame()
	SceneSwitcher.switch_scene(Globals.level_1)


func _on_texture_button_save_2_pressed():
	audioUI.set_stream(klick1)
	audioUI.play()
	Globals.current_save = Globals.save_2
	Globals.loadGame()
	SceneSwitcher.switch_scene(Globals.level_1)


func _on_texture_button_save_3_pressed():
	audioUI.set_stream(klick1)
	audioUI.play()
	Globals.current_save = Globals.save_3
	Globals.loadGame()
	SceneSwitcher.switch_scene(Globals.level_1)


func _on_texture_button_back_pressed():
	playMenu.visible = false
	mainMenu.visible = true
	audioUI.set_stream(klick1)
	audioUI.play()
	$MainMenu/VBoxContainer/TextureButtonPlay.grab_focus()


func _on_texture_button_reset_1_pressed():
	audioUI.set_stream(klick1)
	audioUI.play()
	Globals.reset(Globals.save_1)


func _on_texture_button_reset_2_pressed():
	audioUI.set_stream(klick1)
	audioUI.play()
	Globals.reset(Globals.save_2)


func _on_texture_button_reset_3_pressed():
	audioUI.set_stream(klick1)
	audioUI.play()
	Globals.reset(Globals.save_3)


func _on_texture_button_back_2_pressed():
	optionsMenu.visible = false
	mainMenu.visible = true
	Globals.settingsSave()
	audioUI.set_stream(klick1)
	audioUI.play()
	$MainMenu/VBoxContainer/TextureButtonPlay.grab_focus()


func _on_h_slider_main_value_changed(value):
	audioUI.set_stream(scroll)
	audioUI.play()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),value)


func _on_h_slider_music_value_changed(value):
	audioUI.set_stream(scroll)
	audioUI.play()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),value)


func _on_h_slider_effects_value_changed(value):
	audioUI.set_stream(scroll)
	audioUI.play()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"),value)


func _on_h_slider_ui_value_changed(value):
	audioUI.set_stream(scroll)
	audioUI.play()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("UI"),value)


func _on_texture_button_back_3_pressed():
	audioUI.set_stream(klick1)
	audioUI.play()
	creditsMenu.visible = false
	mainMenu.visible = true
	$MainMenu/VBoxContainer/TextureButtonPlay.grab_focus()
#endregion


#region Hovers
func _on_texture_button_play_mouse_entered():
	audioUI.set_stream(hover)
	audioUI.play()


func _on_texture_button_options_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(hover)
		audioUI.play()


func _on_texture_button_credits_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(hover)
		audioUI.play()


func _on_texture_button_quit_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(hover)
		audioUI.play()


func _on_texture_button_save_1_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(hover)
		audioUI.play()


func _on_texture_button_save_2_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(hover)
		audioUI.play()


func _on_texture_button_save_3_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(hover)
		audioUI.play()


func _on_texture_button_back_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(hover)
		audioUI.play()


func _on_texture_button_reset_1_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(hover)
		audioUI.play()


func _on_texture_button_reset_2_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(hover)
		audioUI.play()


func _on_texture_button_reset_3_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(hover)
		audioUI.play()


func _on_texture_button_back_2_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(hover)
		audioUI.play()


func _on_h_slider_main_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(hover)
		audioUI.play()


func _on_h_slider_music_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(hover)
		audioUI.play()


func _on_h_slider_effects_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(hover)
		audioUI.play()


func _on_h_slider_ui_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(hover)
		audioUI.play()


func _on_texture_button_back_3_mouse_entered():
	if audioUI.playing == false:
		audioUI.set_stream(hover)
		audioUI.play()

#endregion
