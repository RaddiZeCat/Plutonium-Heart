extends Node2D

@onready var audioMusic = $AudioStreamPlayer
@export var track:AudioStream

func pause():
	get_tree().paused = true

func unpause():
	get_tree().paused = false

func _ready():
	audioMusic.play()


func _on_audio_stream_player_finished():
	audioMusic.play()
